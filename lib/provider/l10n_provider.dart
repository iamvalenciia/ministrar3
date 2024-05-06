import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class L10nNotifier extends ChangeNotifier {
  L10nNotifier() {
    _loadLanguage();
  }

  Locale? _appLocale;

  Locale? get appLocale => _appLocale;

  void setLanguage(Locale selectedLocale) {
    _appLocale = selectedLocale;
    _saveLanguage(selectedLocale);
    notifyListeners();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      _appLocale = Locale(languageCode);
    }
    notifyListeners();
  }

  Future<void> _saveLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
  }
}
