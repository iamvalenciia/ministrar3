import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadThemeData();
  }
  ThemeData _themeDataStyle = ThemeDataStyle.light;

  ThemeData get themeDataStyle => _themeDataStyle;

  set themeDataStyle(ThemeData themeData) {
    _themeDataStyle = themeData;
    _saveThemeData(themeData);
    notifyListeners();
  }

  Future<void> _loadThemeData() async {
    final prefs = await SharedPreferences.getInstance();
    final themeDataString = prefs.getString('themeData');
    if (themeDataString == 'light') {
      _themeDataStyle = ThemeDataStyle.light;
    } else {
      _themeDataStyle = ThemeDataStyle.dark;
    }
    notifyListeners();
  }

  Future<void> _saveThemeData(ThemeData themeData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'themeData', themeData == ThemeDataStyle.light ? 'light' : 'dark');
  }

  void changeTheme() {
    if (_themeDataStyle == ThemeDataStyle.light) {
      themeDataStyle = ThemeDataStyle.dark;
    } else {
      themeDataStyle = ThemeDataStyle.light;
    }
  }
}
