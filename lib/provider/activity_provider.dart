import 'dart:async';
import 'dart:developer' as developer;
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

import '../models/activity_model/activity_model.dart';
import '../services/supabase.dart';

//------------------------------
// LIST ACTIVITIES NOTIFIER
//------------------------------

class ActivityNotifier extends ChangeNotifier {
  List<Activity>? _last4Activities;
  List<Activity>? _helpActivities;
  bool _wasLastActivityHelpTrue = false;
  bool _isHelpActivityLoading = true;
  bool _isLoadingHelpButton = false;
  final Map<String, bool> _isHelping = {};

  List<Activity>? get activities => _last4Activities;
  List<Activity>? get helpActivities => _helpActivities;
  bool get isHelpActivityLoading => _isHelpActivityLoading;
  bool get wasLastActivityHelpTrue => _wasLastActivityHelpTrue;
  bool get isLoadingHelpBotton => _isLoadingHelpButton;

  // Add a new method to get the helping state for a specific user
  bool isHelping(String helpRequestId) {
    return _isHelping[helpRequestId] ?? false;
  }

  bool? helped(String helpRequestId) {
    final activity = _helpActivities?.firstWhereOrNull(
      (activity) => activity.help_request_id.toString() == helpRequestId,
    );

    return activity?.status;
  }

  void createLocalPostActivity() {
    final postOwnerId = supabase.auth.currentUser?.id;
    final Activity newActivity = Activity(
      activity_type: 'post',
      activity_owner_id: postOwnerId,
      inserted_at: DateTime.now(),
    );

    // Add the new activity to the beginning of the list
    _last4Activities?.insert(0, newActivity);
    notifyListeners();
  }

  Future<void> fetchTheLastFourActivities() async {
    _isHelpActivityLoading = true;
    notifyListeners();
    try {
      final userId = supabase.auth.currentUser?.id;

      final List<dynamic> response =
          await supabase.rpc('get_4_activities', params: {
        'p_activity_owner': userId,
      });
      // Check if the last activity was a help activity so
      // this allow user if can create help request or no
      await wasLastActivityHelp();

      developer.log('fetchTheLastFourActivities',
          error: response, name: 'fetchTheLastFourActivities');

      _last4Activities =
          // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
          response
              .map((json) => Activity.fromJson(json as Map<String, dynamic>))
              .toList();
    } catch (e) {
      developer.log('ERROR fetchTheLastFourActivities',
          error: e, name: 'ERROR fetchTheLastFourActivities');
    } finally {
      _isHelpActivityLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchHelpActivities() async {
    _isHelpActivityLoading = true;
    notifyListeners();
    try {
      final userId = supabase.auth.currentUser?.id;

      final List<dynamic> response =
          await supabase.rpc('get_help_activities', params: {
        'p_activity_owner': userId,
      });

      developer.log('fetchHelpActivities',
          error: response, name: 'fetchHelpActivities');

      _helpActivities =
          // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
          response
              .map((json) => Activity.fromJson(json as Map<String, dynamic>))
              .toList();
      // Update _isHelping for each fetched help activity
      for (final activity in _helpActivities!) {
        _isHelping[activity.help_request_id.toString()] = true;
      }
    } catch (e) {
      developer.log('ERROR fetchHelpActivities',
          error: e, name: 'ERROR fetchHelpActivities');
    } finally {
      _isHelpActivityLoading = false;
      notifyListeners();
    }
  }

  Future<void> createHelpActivity(
      int helpRequestId, String helpRequestOwnerid) async {
    _isLoadingHelpButton = true;
    notifyListeners();
    try {
      final activityOwner = supabase.auth.currentUser?.id;
      await supabase.from('activities').insert([
        <String, dynamic>{
          'activity_type': 'help',
          'activity_owner_id': activityOwner,
          'help_request_id': helpRequestId,
          'help_request_owner_id': helpRequestOwnerid,
        }
      ]);

      final Activity helpActivity = Activity(
        activity_type: 'help',
        activity_owner_id: activityOwner,
        inserted_at: DateTime.now(),
        help_request_id: helpRequestId,
      );
      _helpActivities?.insert(0, helpActivity);
      _isHelping[helpRequestId.toString()] = true;
      notifyListeners();
    } catch (e) {
      developer.log('Error in createHelpActivity', error: e);
    } finally {
      _isLoadingHelpButton = false;
      notifyListeners();
    }
  }

  Future<void> removeMyHelpActivity(int helpRequestId) async {
    _isLoadingHelpButton = true;
    notifyListeners();
    final activity = _helpActivities?.firstWhere(
      (activity) => activity.help_request_id == helpRequestId,
    );
    try {
      await supabase.rpc('delete_my_help_activity', params: {
        'p_activity_owner_id': activity?.activity_owner_id,
        'p_activity_type': activity?.activity_type,
        'p_help_request_id': helpRequestId,
      });

      // Remove the activity from _helpActivities
      _helpActivities?.remove(activity);
      // Update the helping state
      _isHelping[helpRequestId.toString()] = false;
      notifyListeners();
    } catch (e) {
      developer.log(e.toString(), name: 'ERROR removeMyHelpActivity');
    } finally {
      _isLoadingHelpButton = false;
      notifyListeners();
    }
  }

  Future<void> wasLastActivityHelp() async {
    final userId = supabase.auth.currentUser?.id;
    final bool response = await supabase.rpc('was_last_activity_help', params: {
      'p_activity_owner': userId,
    });
    _wasLastActivityHelpTrue = response;
  }

  void clearIsHelping() {
    _isHelping.clear();
    notifyListeners();
  }

  void clearHelpActivities() {
    _helpActivities = null;
    notifyListeners();
  }

  void clearLastFourActivities() {
    _last4Activities = null;
    notifyListeners();
  }
}
