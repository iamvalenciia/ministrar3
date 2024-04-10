import 'dart:async';
import 'package:flutter/material.dart';
import '../models/people_helping_in_my_hr/people_helping_in_my_hr.dart';
import '../services/supabase.dart'; // Import your Supabase service

class PeopleHelpingNotifier extends ChangeNotifier {
  List<PeopleHelpingInMyHelpRequest>? _peopleHelping = [];
  bool _isLoading = true;

  List<PeopleHelpingInMyHelpRequest>? get peopleHelping => _peopleHelping;
  bool get isLoading => _isLoading;

  Future<void> fetchPeopleHelpingInMyHelpRequest() async {
    final String helpRequestOwnerId = supabase.auth.currentUser?.id ?? 'xd';
    _isLoading = true;
    notifyListeners();
    try {
      final List<dynamic> response = await supabase.rpc(
          'fetch_people_helping_in_my_help_request',
          params: <String, String>{
            'p_help_request_owner_id': helpRequestOwnerId,
          });

      _peopleHelping = response
          .map((json) => PeopleHelpingInMyHelpRequest.fromJson(
              json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching people helping in my help request: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
