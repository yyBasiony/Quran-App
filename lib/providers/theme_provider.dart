import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  final String _boxKey = 'themeBox';

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemeFromBox();
  }

  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    _saveThemeToBox(isOn);
    notifyListeners();
  }

  void _loadThemeFromBox() async {
    var box = await Hive.openBox(_boxKey);
    _isDarkMode = box.get('isDarkMode', defaultValue: false);
    notifyListeners();
  }

  void _saveThemeToBox(bool isDark) async {
    var box = await Hive.openBox(_boxKey);
    box.put('isDarkMode', isDark);
  }
}
