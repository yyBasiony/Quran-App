import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late final SharedPreferences _prefs;
  static const String _isDarkMode = 'IS_DARK_MODE_PREFS_KEY';
  static const String _isFirstTime = 'IS_FIRST_TIME_PREFS_KEY';
  static const String _languageCode = 'LANGUAGE_CODE_PREFS_KEY';
  static const String _selectedCity = 'SELECTED_CODE_PREFS_KEY';

  static Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  static bool isFirstTime() => _prefs.getBool(_isFirstTime) ?? true;

  static Future<void> setFirstTime() async => await _prefs.setBool(_isFirstTime, false);

  static String getSelectedCity([String city = 'Zagazig']) => _prefs.getString(_selectedCity) ?? city;

  static Future<void> setSelectedCity(String city) async => await _prefs.setString(_selectedCity, city);

  static bool getTheme() => _prefs.getBool(_isDarkMode) ?? false;

  static Future<void> setTheme(bool isDark) async => await _prefs.setBool(_isDarkMode, isDark);

  static String getLanguageCode() => _prefs.getString(_languageCode) ?? 'ar';

  static Future<void> setLanguageCode(String code) async => await _prefs.setString(_languageCode, code);
}
