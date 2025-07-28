import 'dart:convert';
import '../../models/prayer_times_model.dart';
import '../../../app/app_preferences.dart';

class PrayerTimesCache {
  static Future<PrayerTimesModel?> getLastAvailablePrayerTimes(String city) async {
    final prefs = AppPreferences.prefs;

    for (int i = 0; i < 7; i++) {
      final date = DateTime.now().subtract(Duration(days: i));
      final dateString = date.toString().substring(0, 10);
      final key = 'prayerTimes_${dateString}_$city';

      if (prefs.containsKey(key)) {
        final cachedData = prefs.getString(key);
        if (cachedData != null) {
          final timingsMap = jsonDecode(cachedData);
          return PrayerTimesModel.fromJson(timingsMap);
        }
      }
    }
    return null;
  }

  static Future<void> savePrayerTimes(String city, DateTime date, Map<String, dynamic> timings) async {
    final prefs = AppPreferences.prefs;
    final dateString = date.toString().substring(0, 10);
    final key = 'prayerTimes_${dateString}_$city';
    final jsonString = jsonEncode(timings);
    await prefs.setString(key, jsonString);
  }
}
