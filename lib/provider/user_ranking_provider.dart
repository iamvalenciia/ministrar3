import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import '../models/user_ranking_model/user_ranking_model.dart';
import '../services/supabase.dart'; // Import your Supabase service

class UserRankingNotifier extends ChangeNotifier {
  List<UserRanking>? _userRakingAndNeighbors = [];
  bool _isLoading = true;

  List<UserRanking>? get userRakingAndNeighbors => _userRakingAndNeighbors;
  bool get isLoading => _isLoading;

  Future<void> fetchUserRakingAndNeighbors() async {
    clearPeopleHelping();
    final userId = supabase.auth.currentUser?.id;
    _isLoading = true;
    notifyListeners();
    try {
      final List<dynamic> response = await supabase
          .rpc('get_user_ranking_and_neighbors', params: <String, dynamic>{
        'p_user_id': userId,
      });

      _userRakingAndNeighbors = response
          .map((json) => UserRanking.fromJson(json as Map<String, dynamic>))
          .toList();
      developer.log(response.toString(), name: 'fetchUserRakingAndNeighbors');
    } catch (e) {
      developer.log(e.toString(), name: 'ERROR fetchUserRakingAndNeighbors');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPeopleHelping() {
    _userRakingAndNeighbors = [];
    notifyListeners();
  }
}
