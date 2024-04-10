import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import '../models/activity_model/activity_model.dart';
import '../services/supabase.dart';

//------------------------------
// LIST ACTIVITIES NOTIFIER
//------------------------------

class ActivityNotifier extends ChangeNotifier {
  List<Activity>? _activityPosts;
  List<Activity>? _helpActivities;
  List<Activity>? _helpActivitiesFromMyHelpRequest;
  bool _isLoading = true;
  bool _isHelpActivityLoading = true;
  final Map<String, bool> _isHelping = {};

  List<Activity>? get activityPosts => _activityPosts;
  List<Activity>? get helpActivities => _helpActivities;
  List<Activity>? get helpActivitiesFromMyHelpRequest =>
      _helpActivitiesFromMyHelpRequest;
  bool get isHelpActivityLoading => _isHelpActivityLoading;
  bool get isLoading => _isLoading;

  Future<void> activities() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userId = supabase.auth.currentUser?.id;

      final List<dynamic> response =
          await supabase.rpc('get_last_activities', params: {
        'p_user_id': userId,
      });

      developer.log('fetchPostActivity',
          error: response, name: 'fetchPostActivity');

      _activityPosts =
          // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
          response
              .map((json) => Activity.fromJson(json as Map<String, dynamic>))
              .toList();
    } catch (e) {
      developer.log('ERROR fetchPostActivity',
          error: e, name: 'ERROR fetchPostActivity');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new method to get the helping state for a specific user
  bool isHelping(String userId) {
    return _isHelping[userId] ?? false;
  }

  void createLocalActivity() {
    final postOwnerId = supabase.auth.currentUser?.id;
    final Activity newActivity = Activity(
      activity_owner: postOwnerId!,
      inserted_at: DateTime.now(),
      help_request_owner_id: postOwnerId,
    );

    // Remove the last activity if the list is not empty
    if (_activityPosts != null && _activityPosts!.isNotEmpty) {
      _activityPosts!.removeLast();
    }

    // Add the new activity to the beginning of the list
    _activityPosts?.insert(0, newActivity);
    notifyListeners();
  }

  Future<void> fetchMyHelpActivities() async {
    _isHelpActivityLoading = true;
    notifyListeners();
    try {
      final userId = supabase.auth.currentUser?.id;

      final List<dynamic> response =
          await supabase.rpc('fetch_my_help_activities', params: {
        'p_activity_owner': userId,
      });

      developer.log('fetchMyHelpActivities',
          error: response, name: 'fetchMyHelpActivities');

      _helpActivities =
          // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
          response
              .map((json) => Activity.fromJson(json as Map<String, dynamic>))
              .toList();
      // Update _isHelping for each fetched help activity
      for (final activity in _helpActivities!) {
        _isHelping[activity.help_request_owner_id.toString()] = true;
      }
    } catch (e) {
      developer.log('ERROR fetchMyHelpActivities',
          error: e, name: 'ERROR fetchMyHelpActivities');
    } finally {
      _isHelpActivityLoading = false;
      notifyListeners();
    }
  }

  Future<void> createHelpActivity(String postOwnerId) async {
    final activityOwner = supabase.auth.currentUser?.id;
    final response = await supabase.from('activities').insert([
      <String, dynamic>{
        'activity_type': 'help',
        'activity_owner': activityOwner,
        'help_request_owner_id': postOwnerId,
      }
    ]).select();

    final newActivity = Activity.fromJson(response[0]);

    // Add the new activity to the beginning of the list
    _helpActivities?.insert(0, newActivity);
    developer.log(helpActivities.toString(),
        name: 'helpActivities after creating new help activity');
    _isHelping[postOwnerId] = true;
    developer.log(_isHelping.toString(),
        name:
            'The list of the variable _isHelping after creating new help activity');
    notifyListeners();
  }

  Future<void> removeMyHelpActivity(String? postOwnerId) async {
    developer.log(helpActivities.toString(), name: 'helpActivities');
    try {
      final activityOwner = supabase.auth.currentUser?.id;
      final activity = _helpActivities?.firstWhere(
        (activity) => activity.help_request_owner_id == postOwnerId,
      );
      developer.log('${activity?.activity_id}', name: 'activity_id');
      await supabase
          .from('activities')
          .delete()
          .eq('activity_id', '${activity?.activity_id}');
      _helpActivities?.removeWhere((activity) =>
          activity.activity_owner == activityOwner &&
          activity.help_request_owner_id == postOwnerId);
      // Update the helping state
      _isHelping[postOwnerId!] = false;
      notifyListeners();
    } catch (e) {
      developer.log(e.toString(), name: 'ERROR removeMyHelpActivity');
    }
  }
}
