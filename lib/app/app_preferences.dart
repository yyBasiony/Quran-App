import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
   static const String _keySelectedCity = 'selected_city';
  static const String _keyHasStarted = 'is_first_time';
  static const _isDarkModeKey = 'isDarkMode';
  static const _languageCodeKey = 'languageCode';

//city
  static Future<void> setSelectedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySelectedCity, city);
  }

  static Future<String> getSelectedCity([String defaultValue = 'Zagazig']) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySelectedCity) ?? defaultValue;
  }
//start screen
  static Future<void> setHasStarted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasStarted, value);
  }

  static Future<bool> hasStartedBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasStarted) ?? false;
  }
  //theme
    static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  static Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, isDark);
  }
//localization
  static Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageCodeKey) ?? 'ar';
  }

  static Future<void> setLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, code);
  }

}
