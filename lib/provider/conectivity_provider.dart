import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum ConnectivityStatus { WiFi, Cellular, Ethernet, Offline }

class ConnectivityProvider extends ChangeNotifier {
  late Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityStatus _status = ConnectivityStatus.Offline;
  ConnectivityStatus get status => _status;

  ConnectivityProvider() {
    _connectivity = Connectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        // Assuming non-empty list (as per documentation), handle the first result
        if (results.isNotEmpty) {
          _updateConnectionStatus(results.first);
        }
      },
    );
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    final List<ConnectivityResult> result =
        await _connectivity.checkConnectivity();
    if (result.isNotEmpty) {
      _updateConnectionStatus(result.first);
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        _status = ConnectivityStatus.WiFi;
        break;
      case ConnectivityResult.mobile:
        _status = ConnectivityStatus.Cellular;
        break;
      case ConnectivityResult.ethernet:
        _status = ConnectivityStatus.Ethernet;
        break;
      case ConnectivityResult.none:
        _status = ConnectivityStatus.Offline;
        break;
      default:
        _status = ConnectivityStatus.Offline;
        break;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
