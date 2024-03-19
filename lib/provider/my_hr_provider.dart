import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ministrar3/models/help_requests_model/help_request_model.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer;
import 'dart:async';

//---------------------------
// MY HELP REQUEST NOTIFIER
//---------------------------

class MyHelpRequestNotifier extends ChangeNotifier {
  HelpRequestModel? _myHelpRequest;
  bool _isLoading = true;
  bool isFirstLoad = true;
  String? _error;
  StreamSubscription<Position>? _positionStreamSubscription;

  HelpRequestModel? get myHelpRequest => _myHelpRequest;
  bool get isLoading => _isLoading;
  String? get error => _error;

  MyHelpRequestNotifier() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(distanceFilter: 0),
    ).listen(_updateDistance);
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void _updateDistance(Position position) {
    final userLat = position.latitude;
    final userLong = position.longitude;

    if (_myHelpRequest != null) {
      final helpRequestLat = _myHelpRequest!.lat ?? 0.0;
      final helpRequestLong = _myHelpRequest!.long ?? 0.0;
      final distanceInMeters = Geolocator.distanceBetween(
        userLat,
        userLong,
        helpRequestLat,
        helpRequestLong,
      );
      _myHelpRequest = _myHelpRequest!.copyWith(distance: distanceInMeters);
    }

    notifyListeners();
  }

  Future<void> fetchMyHelpRequest() async {
    _isLoading = true;
    notifyListeners();
    try {
      final userId = supabase.auth.currentUser?.id;

      final response = await supabase.rpc('help_request_from_user', params: {
        'f_user_id': userId,
      });

      developer.log('fetchMyHelpRequest',
          error: response[0], name: 'fetchMyHelpRequest');

      _myHelpRequest = HelpRequestModel.fromJson(response[0]);
    } catch (e) {
      developer.log(' fetchMyHelpRequest ERROR',
          error: e, name: ' fetchMyHelpRequest ERROR');
      _error = e.toString();
    } finally {
      isFirstLoad = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createMyHelpRequest(String category, String content) async {
    developer.log(category, name: 'category');
    try {
      Location location = Location();
      LocationData locationData = await location.getLocation();
      final latitude = locationData.latitude;
      final longitude = locationData.longitude;
      final userId = supabase.auth.currentUser?.id;
      final response = await supabase.rpc('create_hr_and_activity', params: {
        'p_user_id': userId,
        'p_category': category,
        'p_content': content,
        'p_latitude': latitude,
        'p_longitude': longitude,
        'p_inserted_at': DateTime.now().toIso8601String(),
      });

      developer.log('createMyHelpRequest',
          error: response[0], name: 'createMyHelpRequest');

      _myHelpRequest = HelpRequestModel.fromJson(response[0]);
      notifyListeners();
      return true;
    } catch (e) {
      developer.log('createMyHelpRequest ERROR',
          error: e, name: 'createMyHelpRequest ERROR');
      _error = e.toString();
    }
    return false;
  }

  Future<bool> deleteMyHelpRequest() async {
    // this function delete help request and the activities belongs to the help request
    // will delete all activities where status is either null or false
    try {
      final userId = supabase.auth.currentUser?.id;
      await supabase.rpc('delete_hr_and_activity', params: {
        'p_user_id': userId,
      });

      developer.log('deleteMyHelpRequest', name: 'deleteMyHelpRequest');

      return true;
    } catch (e) {
      developer.log('deleteMyHelpRequest ERROR',
          error: e, name: 'deleteMyHelpRequest ERROR');
      _error = e.toString();
    }
    return false;
  }

  void clearHelpRequest() {
    _myHelpRequest = null;
    notifyListeners();
  }
}
