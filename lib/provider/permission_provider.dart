import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:developer' as developer;

class PermissionProvider extends ChangeNotifier {
  PermissionStatus _permissionGranted = PermissionStatus.denied;

  PermissionStatus get permissionGranted => _permissionGranted;

  void update(PermissionStatus status) {
    _permissionGranted = status;
    notifyListeners();
  }

  // Move checkLocationPermission to a separate file
  Future<void> checkLocationPermission() async {
    try {
      final permissionStatus = await Location().hasPermission();
      update(permissionStatus);
    } catch (e) {
      developer.log('Failed to check location permissions', error: e);
    }
  }
}
