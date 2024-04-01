import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionNotifier extends ChangeNotifier {
  LocationPermissionNotifier() {
    checkLocationPermission();
  }

  bool _hasLocationPermission = false;

  bool get hasLocationPermission => _hasLocationPermission;

  Future<void> checkLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    final hasPermission = permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever;

    if (hasPermission != _hasLocationPermission) {
      _hasLocationPermission = hasPermission;
      notifyListeners();
    }
  }

  Future<void> requestLocationPermission() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      developer.log('Location permission denied forever');
    } else if (permission == LocationPermission.denied) {
      developer.log('Location permission denied');
      final newPermission = await Geolocator.requestPermission();

      if (newPermission == LocationPermission.denied ||
          newPermission == LocationPermission.deniedForever) {
        _hasLocationPermission = false;
      } else if (newPermission == LocationPermission.whileInUse ||
          newPermission == LocationPermission.always) {
        _hasLocationPermission = true;
      }

      notifyListeners();
    }
  }
}
