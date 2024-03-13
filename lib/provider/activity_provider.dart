import 'package:flutter/material.dart';
import 'package:ministrar3/models/activity_help_model/activity_help_model.dart';
import 'package:ministrar3/models/activity_post_model/activity_post_model.dart';
import 'package:ministrar3/services/supabase.dart';
import 'dart:developer' as developer;
import 'dart:async';

//------------------------------
// LIST ACTIVITIES NOTIFIER
//------------------------------

class ActivityNotifier extends ChangeNotifier {
  List<ActivityHelpModel>? _activityHelps;
  List<ActivityPostModel>? _activityPosts;
  bool _isLoading = true;

  List<ActivityHelpModel>? get activityHelps => _activityHelps;
  List<ActivityPostModel>? get activityPosts => _activityPosts;
  bool get isLoading => _isLoading;

  Future<void> fetchPostActivity() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userId = supabase.auth.currentUser?.id;

      final response = await supabase
          .from('post_activity')
          .select('*')
          .eq('owner_id', '${userId}');

      developer.log('fetchPostActivity',
          error: response, name: 'fetchPostActivity');

      _activityPosts =
          response.map((json) => ActivityPostModel.fromJson(json)).toList();
    } catch (e) {
      developer.log('ERROR fetchPostActivity',
          error: e, name: 'ERROR fetchPostActivity');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
