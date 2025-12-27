import '../../app/app_preferences.dart';

class SelectedCityManager {
  static String getSelectedCity() => AppPreferences.getSelectedCity();

  static Future<void> setSelectedCity(String city) =>
      AppPreferences.setSelectedCity(city);
}
