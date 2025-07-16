import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
   static const String _keySelectedCity = 'selected_city';
  static const String _keyHasStarted = 'is_first_time';
  static const _isDarkModeKey = 'isDarkMode';
  static const _languageCodeKey = 'languageCode';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('AppPreferences not initialized.');
    }
    return _prefs!;
  }

//city
  static Future<void> setSelectedCity(String city) async =>
    await prefs.setString(_keySelectedCity, city);

  static String getSelectedCity([String defaultValue = 'Zagazig'])  =>
     prefs.getString(_keySelectedCity) ?? defaultValue;
//start screen
  static Future<void> setHasStarted(bool value) async {
    await prefs.setBool(_keyHasStarted, value);
  }

  static bool hasStartedBefore()  =>
     prefs.getBool(_keyHasStarted) ?? false;
  
  //theme
    static bool getTheme()  =>
     prefs.getBool(_isDarkModeKey) ?? false;
  

  static void setTheme(bool isDark)  =>
     prefs.setBool(_isDarkModeKey, isDark);
  
//localization
  static Future<String> getLanguageCode() async =>
     prefs.getString(_languageCodeKey) ?? 'ar';
  

  static void setLanguageCode(String code)  =>
     prefs.setString(_languageCodeKey, code);
  

}