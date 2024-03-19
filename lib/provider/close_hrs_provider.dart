import 'package:flutter/material.dart';
import 'package:ministrar3/models/help_requests_model/help_request_model.dart';
import 'package:ministrar3/services/supabase.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer' as developer;
import 'dart:async';

//------------------------------
// LIST HELP REQUESTS NOTIFIER
//------------------------------

class HelpRequestsNotifier extends ChangeNotifier {
  List<HelpRequestModel>? _helpRequests;
  bool _isLoading = true;
  bool isFirstLoad = true;
  String? _error;
  StreamSubscription<Position>? _positionStreamSubscription;

  List<HelpRequestModel>? get helpRequests => _helpRequests;
  bool get isLoading => _isLoading;
  String? get error => _error;

  HelpRequestsNotifier() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(distanceFilter: 0),
    ).listen(_updateDistances);
  }

  void _updateDistances(Position position) {
    final userLat = position.latitude;
    final userLong = position.longitude;

    _helpRequests = _helpRequests?.map((helpRequest) {
      final helpRequestLat = helpRequest.lat ?? 50;
      final helpRequestLong = helpRequest.long ?? 0.0;
      final distanceInMeters = Geolocator.distanceBetween(
        userLat,
        userLong,
        helpRequestLat,
        helpRequestLong,
      );
      return helpRequest.copyWith(distance: distanceInMeters);
    }).toList();

    notifyListeners();
  }

  Future<void> fetchHelpRequests() async {
    _isLoading = true;
    notifyListeners();
    try {
      Location location = Location();
      LocationData locationData = await location.getLocation();
      final userId = supabase.auth.currentUser?.id;

      final response = userId != null
          // get all help requests (logged in user)
          ? await supabase.rpc('help_requests_for_user', params: {
              'ref_latitude': locationData.latitude,
              'ref_longitude': locationData.longitude,
              'query_user_id': userId,
            })
          // get all help requests (guest user)
          : await supabase.rpc('help_requests_for_guest', params: {
              'ref_latitude': locationData.latitude,
              'ref_longitude': locationData.longitude,
            });

      developer.log('RESPONSE', error: response, name: 'RESPONSE');

      _handleResponse(response);
    } catch (e) {
      developer.log('ERROR', error: e, name: 'ERROR');
      _error = e.toString();
    } finally {
      isFirstLoad = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handleResponse(dynamic response) {
    if (response is List) {
      _helpRequests =
          response.map((json) => HelpRequestModel.fromJson(json)).toList();
    } else {
      _error = 'Unexpected response data';
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}
