import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/help_requests_model/help_request_model.dart';
import '../services/supabase.dart';

class MyHelpRequestNotifier extends ChangeNotifier {
  MyHelpRequestNotifier() {
    _loadDistancePreference();
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(),
    ).listen(_updateDistance);
  }

  HelpRequestModel? _myHelpRequest;
  double? _distance;
  bool _isLoading = true;
  bool isFirstLoad = true;
  String? _error;
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isDistanceInKilometers = true;

  HelpRequestModel? get myHelpRequest => _myHelpRequest;
  double? get distance => _distance;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isDistanceInKilometers => _isDistanceInKilometers;

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void _updateDistance(Position position) {
    final double userLat = position.latitude;
    final double userLong = position.longitude;

    if (_myHelpRequest != null) {
      final double helpRequestLat = _myHelpRequest!.lat ?? 0.0;
      final double helpRequestLong = _myHelpRequest!.long ?? 0.0;
      _distance = Geolocator.distanceBetween(
            userLat,
            userLong,
            helpRequestLat,
            helpRequestLong,
          ) /
          1000; // Convert meters to kilometers

      // Convert to miles if _isDistanceInKilometers is false
      if (!_isDistanceInKilometers) {
        _distance = _distance! *
            0.621371; // 1 kilometer is approximately 0.621371 miles
      }
    }

    notifyListeners();
  }

  Future<void> _loadDistancePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDistanceInKilometers = prefs.getBool('isDistanceInKilometers') ?? true;
    notifyListeners();
  }

  Future<void> switchDistanceUnit() async {
    _isDistanceInKilometers = !_isDistanceInKilometers;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDistanceInKilometers', _isDistanceInKilometers);
    notifyListeners(); // Notify listeners to update the UI
  }

  Future<void> fetchMyHelpRequest() async {
    final String? userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await supabase.rpc('help_request_from_user', params: <String, String>{
        'f_user_id': userId,
      });

      if (response is List && response.isNotEmpty) {
        final List<HelpRequestModel> helpRequests = response.map((item) {
          if (item is Map<String, dynamic>) {
            return HelpRequestModel.fromJson(item);
          }
          throw TypeError();
        }).toList();

        developer.log(helpRequests[0].toString(), name: 'fetchMyHelpRequest');

        _myHelpRequest = helpRequests[0];
      } else {
        developer.log(response.toString(), name: 'fetchMyHelpRequest');
      }
    } catch (e) {
      developer.log(e.toString(), name: ' fetchMyHelpRequest ERROR');
      _error = e.toString();
    } finally {
      isFirstLoad = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createMyHelpRequest(
      String category,
      String content,
      String phone,
      String xTwitter,
      String instagram,
      bool locationSharingEnable) async {
    developer.log(category, name: 'category');
    try {
      final Position position = await Geolocator.getCurrentPosition();
      final double latitude = position.latitude;
      final double longitude = position.longitude;
      final String? userId = supabase.auth.currentUser?.id;
      final response = await supabase
          .rpc('create_hr_and_activity', params: <String, dynamic>{
        'p_help_request_owner_id': userId,
        'p_category': category,
        'p_content': content,
        'p_latitude': latitude,
        'p_longitude': longitude,
        'p_phone': phone,
        'p_twitter': xTwitter,
        'p_instagram': instagram,
        'p_location_sharing_enable': locationSharingEnable,
      });

      developer.log('createMyHelpRequest',
          // ignore: avoid_dynamic_calls
          error: response[0],
          name: 'createMyHelpRequest');

      // ignore: avoid_dynamic_calls
      _myHelpRequest =
          HelpRequestModel.fromJson(response[0] as Map<String, dynamic>);
      notifyListeners();
      return true;
    } catch (e) {
      developer.log(e.toString(), name: 'createMyHelpRequest ERROR');
      _error = e.toString();
    }
    return false;
  }

  Future<bool> updateMyHelpRequest(
    String category,
    String content,
    String? phone,
    String? xTwitter,
    String? instagram,
    bool locationSharingEnable,
  ) async {
    try {
      final String? userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        return false;
      }

      // Check if values are the same as before
      if (_myHelpRequest!.category == category &&
          _myHelpRequest!.content == content &&
          _myHelpRequest!.phone_number ==
              // ignore: use_if_null_to_convert_nulls_to_bools
              (phone?.isEmpty == true ? null : phone) &&
          _myHelpRequest!.x_username ==
              // ignore: use_if_null_to_convert_nulls_to_bools
              (xTwitter?.isEmpty == true ? null : xTwitter) &&
          _myHelpRequest!.instagram_username ==
              // ignore: use_if_null_to_convert_nulls_to_bools
              (instagram?.isEmpty == true ? null : instagram) &&
          _myHelpRequest!.location_sharing_enabled == locationSharingEnable) {
        // Values are the same, no need to update
        return false;
      }

      // Assign null to phone, xTwitter, and instagram if they are empty
      phone = phone?.isNotEmpty ?? false ? phone : null;
      xTwitter = xTwitter?.isNotEmpty ?? false ? xTwitter : null;
      instagram = instagram?.isNotEmpty ?? false ? instagram : null;

      developer.log('help request is getting update in the database :)',
          name: 'updateMyHelpRequest');

      await supabase.from('help_requests').update(<String, dynamic>{
        'category': category,
        'content': content,
        'phone_number': phone,
        'x_username': xTwitter,
        'instagram_username': instagram,
        'location_sharing_enabled': locationSharingEnable,
      }).eq('help_request_owner_id', userId);

      // Update local data
      _myHelpRequest?.category = category;
      _myHelpRequest?.content = content;
      _myHelpRequest?.phone_number = phone;
      _myHelpRequest?.x_username = xTwitter;
      _myHelpRequest?.instagram_username = instagram;
      _myHelpRequest?.location_sharing_enabled = locationSharingEnable;

      notifyListeners();
      return true;
    } catch (e) {
      developer.log(e.toString(), name: 'updateMyHelpRequest ERROR');
      _error = e.toString();
    }
    return false;
  }

  Future<bool> deleteMyHelpRequest() async {
    // this function delete help request and the activities belongs to the help request
    // will delete all activities where status is either null or false
    try {
      final String? userId = supabase.auth.currentUser?.id;
      developer.log('p_user_id: $userId', name: 'delete_hr_and_activity');
      developer.log('_myHelpRequest?.hr_id: ${_myHelpRequest?.hr_id}',
          name: 'delete_hr_and_activity');
      await supabase.rpc('delete_hr_and_activity', params: <String, dynamic>{
        'p_user_id': userId,
        'p_hr_id': _myHelpRequest?.hr_id,
      });

      return true;
    } catch (e) {
      developer.log(e.toString(), name: 'deleteMyHelpRequest ERROR');
      _error = e.toString();
    }
    return false;
  }

  void clearHelpRequest() {
    _myHelpRequest = null;
    notifyListeners();
  }

  void updateReceiveHelpAt() {
    if (_myHelpRequest == null) {
      _myHelpRequest?.receive_help_at = DateTime.now();
    }
    notifyListeners();
  }
}
