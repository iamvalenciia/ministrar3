import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/help_requests_model/help_request_model.dart';
import '../services/supabase.dart';

// CLOSE HELP REQUESTS NOTIFIER

class HelpRequestsNotifier extends ChangeNotifier {
  // Constructor for the HelpRequestsNotifier class.
  // It starts listening to the position stream from the Geolocator.
  // Whenever the position updates, it calls the _updateDistances method.
  HelpRequestsNotifier() {
    _loadDistancePreference();
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(),
    ).listen(_updateDistances);
  }

  List<HelpRequestModel>? _helpRequests;
  List<double>? _distances;
  bool _isLoading = true;
  bool isFirstLoad = true;
  String? _error;
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isDistanceInKilometers = true;

  List<HelpRequestModel>? get helpRequests => _helpRequests;
  List<double>? get distances => _distances;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isDistanceInKilometers => _isDistanceInKilometers;

  // This method is called whenever the user's position updates.
  // It calculates the distance from the user to each help request,
  // and updates the help request's distance property with the calculated distance.
  // Modify the _updateDistances method to update _distances instead of _helpRequests
  void _updateDistances(Position position) {
    final double userLat = position.latitude;
    final double userLong = position.longitude;

    _distances = _helpRequests?.map((HelpRequestModel helpRequest) {
      final double helpRequestLat = helpRequest.lat ?? 0.0;
      final double helpRequestLong = helpRequest.long ?? 0.0;

      developer.log(
          'userLat: $userLat userlong: $userLong, helprlat: $helpRequestLat, helprlong: $helpRequestLong',
          name: 'userLat');
      double distance = Geolocator.distanceBetween(
            userLat,
            userLong,
            helpRequestLat,
            helpRequestLong,
          ) /
          1000; // Convert meters to kilometers

      // Convert to miles if _isDistanceInKilometers is false
      if (!_isDistanceInKilometers) {
        distance *= 0.621371; // 1 kilometer is approximately 0.621371 miles
      }

      return distance;
    }).toList();
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

  // This method fetches help requests from the server.
  // It sets _isLoading to true and notifies listeners before starting the fetch operation.
  // This can be used to show a loading spinner in the UI.
  Future<void> fetchHelpRequests() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get the current location of the user.
      final Position position = await Geolocator.getCurrentPosition();

      // Get the current user's ID.
      final String? userId = supabase.auth.currentUser?.id;

      // If the user is logged in (userId is not null), fetch the help requests for the user.
      // If the user is not logged in (userId is null), fetch the help requests for a guest.
      // The fetched help requests are based on the user's current location.
      final List<dynamic> response = userId != null
          ? await supabase.rpc(
              'help_requests_for_user',
              params: <String, dynamic>{
                'ref_latitude': position.latitude,
                'ref_longitude': position.longitude,
                'query_user_id': userId,
              },
            )
          : await supabase.rpc(
              'help_requests_for_guest',
              params: <String, dynamic>{
                'ref_latitude': position.latitude,
                'ref_longitude': position.longitude,
              },
            );

      // Log the response for debugging purposes.
      developer.log('$response', name: 'fetchHelpRequests');

      // If the response is a list, map it to a list of HelpRequestModel instances.
      // This converts the raw JSON data into a more manageable format.
      _helpRequests = response
          .map(
              (json) => HelpRequestModel.fromJson(json as Map<String, dynamic>))
          .toList();
      clearError();
      // Update the distances list with the new help requests.
      _updateDistances(position);
    } catch (e) {
      // If an error occurs, log it and store it in _error.
      developer.log('$e', name: 'fetchHelpRequestsError');
      _error = e.toString();
    } finally {
      // After the fetch operation is complete, set _isLoading to false and notify listeners.
      // This can be used to hide the loading spinner in the UI.
      isFirstLoad = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  // This method is called when the object is removed from memory.
  // It cancels the position stream subscription to free up resources.
  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void incrementPeopleHelpingCount(int helpRequestId) {
    final index = _helpRequests?.indexWhere((hr) => hr.hr_id == helpRequestId);
    if (index != null && index != -1) {
      final currentCount = _helpRequests![index].people_helping_count ?? 0;
      final updatedHelpRequest = _helpRequests?[index]
          .copyWith(people_helping_count: currentCount + 1);
      // ignore: unnecessary_null_comparison
      if (updatedHelpRequest != null) {
        _helpRequests![index] = updatedHelpRequest;
        notifyListeners();
      }
    }
  }

  void decrementPeopleHelpingCount(int helpRequestId) {
    final index = _helpRequests?.indexWhere((hr) => hr.hr_id == helpRequestId);
    if (index != null && index != -1) {
      final currentCount = _helpRequests![index].people_helping_count ?? 0;
      if (currentCount > 0) {
        final updatedHelpRequest = _helpRequests?[index]
            .copyWith(people_helping_count: currentCount - 1);
        // ignore: unnecessary_null_comparison
        if (updatedHelpRequest != null) {
          _helpRequests![index] = updatedHelpRequest;
          notifyListeners();
        }
      }
    }
  }
}
