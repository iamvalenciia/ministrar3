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
  bool _isLoading = true;

  List<Activity>? get activityPosts => _activityPosts;
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

  void createLocalActivity() {
    final postOwnerId = supabase.auth.currentUser?.id ?? '';
    final Activity newActivity = Activity(
      activity_owner: postOwnerId,
      inserted_at: DateTime.now(),
      post_owner: postOwnerId,
    );

    // Remove the last activity if the list is not empty
    if (_activityPosts != null && _activityPosts!.isNotEmpty) {
      _activityPosts!.removeLast();
    }

    // Add the new activity to the beginning of the list
    _activityPosts?.insert(0, newActivity);
    notifyListeners();
  }
}
