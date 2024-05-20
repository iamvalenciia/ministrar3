import 'package:flutter/material.dart';

class OnboardingNavigation extends ChangeNotifier {
  int? _navigationIndex;

  int? get navigationIndex => _navigationIndex;

  void setNavigationIndex(int number) {
    _navigationIndex = number;
    notifyListeners();
  }
}
