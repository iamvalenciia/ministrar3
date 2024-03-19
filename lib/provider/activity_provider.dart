import 'package:flutter/material.dart';
import 'package:ministrar3/models/activity_model/activity_model.dart';
import 'package:ministrar3/services/supabase.dart';
import 'dart:developer' as developer;
import 'dart:async';

//------------------------------
// LIST ACTIVITIES NOTIFIER
//------------------------------

class ActivityNotifier extends ChangeNotifier {
  List<Activitie>? _activityPosts;
  bool _isLoading = true;

  List<Activitie>? get activityPosts => _activityPosts;
  bool get isLoading => _isLoading;

  Future<void> activities() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userId = supabase.auth.currentUser?.id;

      final response = await supabase
          .from('activities')
          .select('*')
          .eq('activity_owner', '${userId}');

      developer.log('fetchPostActivity',
          error: response, name: 'fetchPostActivity');

      _activityPosts =
          response.map((json) => Activitie.fromJson(json)).toList();
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
    Activitie newActivity = Activitie(
      activity_owner: postOwnerId,
      inserted_at: DateTime.now(),
      post_owner: postOwnerId,
      status: null,
      status_updated_at: null,
    );

    // Add the new activity to the list
    _activityPosts?.add(newActivity);
    notifyListeners();
  }
}
