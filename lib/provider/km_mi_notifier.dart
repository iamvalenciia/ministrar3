import 'package:flutter/foundation.dart';

class DistanceUnitNotifier extends ChangeNotifier {
  bool _isKilometers = true;

  bool get isKilometers => _isKilometers;

  void toggleUnit() {
    _isKilometers = !_isKilometers;
    notifyListeners();
  }
}
