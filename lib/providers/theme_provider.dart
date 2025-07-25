import 'package:flutter/material.dart';
import 'package:qanet/app/app_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentThemeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;


  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    AppPreferences.setTheme(isOn);
    notifyListeners();
  }

  void _loadThemeFromPrefs()  {
    _isDarkMode =  AppPreferences.getTheme();
    notifyListeners();
  }
}
