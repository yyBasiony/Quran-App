import 'package:flutter/material.dart';
import 'package:qanet/app/app_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    AppPreferences.setTheme(isOn);
    notifyListeners();
  }

  void _loadThemeFromPrefs() async {
    _isDarkMode = await AppPreferences.getTheme();
    notifyListeners();
  }
}
