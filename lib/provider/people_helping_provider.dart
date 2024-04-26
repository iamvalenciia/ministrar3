import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import '../models/people_helping_in_my_hr/people_helping_in_my_hr.dart';
import '../services/supabase.dart'; // Import your Supabase service

class PeopleHelpingNotifier extends ChangeNotifier {
  List<PeopleHelpingInMyHelpRequest>? _peopleHelping = [];
  bool _isLoading = true;

  List<PeopleHelpingInMyHelpRequest>? get peopleHelping => _peopleHelping;
  bool get isLoading => _isLoading;

  Future<void> fetchPeopleHelpingInMyHelpRequest() async {
    clearPeopleHelping();
    final helpRequestOwnerId = supabase.auth.currentUser?.id;
    _isLoading = true;
    notifyListeners();
    try {
      final List<dynamic> response = await supabase.rpc(
          'fetch_people_helping_in_my_help_request',
          params: <String, dynamic>{
            'p_help_request_owner_id': helpRequestOwnerId,
          });

      _peopleHelping = response
          .map((json) => PeopleHelpingInMyHelpRequest.fromJson(
              json as Map<String, dynamic>))
          .toList();
      developer.log(response.toString(),
          name: 'fetchPeopleHelpingInMyHelpRequest');
    } catch (e) {
      developer.log(e.toString(),
          name: 'ERROR fetchPeopleHelpingInMyHelpRequest');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateActivityStatusAndHelpRequest(
      int activityId, bool status) async {
    final String helpRequestOwnerId = supabase.auth.currentUser?.id ?? 'xd';
    try {
      await supabase.rpc(
        'update_activity_status_and_receive_help_at',
        params: <String, dynamic>{
          'p_activity_id': activityId,
          'p_status': status.toString(),
          'p_help_request_owner_id': helpRequestOwnerId,
        },
      );
      updateActivityStatusLocally(activityId, status);
    } catch (e) {
      developer.log(e.toString(),
          name: 'ERROR updateActivityStatusAndHelpRequest');
    }
  }

  void updateActivityStatusLocally(int activityId, bool status) {
    final index = _peopleHelping
        ?.indexWhere((activity) => activity.activity_id == activityId);
    if (index != null && index != -1) {
      final updatedActivity = _peopleHelping?[index].copyWith(status: status);
      // ignore: unnecessary_null_comparison
      if (updatedActivity != null) {
        _peopleHelping![index] = updatedActivity;
        notifyListeners();
      }
    }
  }

  void clearPeopleHelping() {
    _peopleHelping = [];
    notifyListeners();
  }
}
