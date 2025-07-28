import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/prayer_times_model.dart';

class PrayerTimesCache {
  static Future<PrayerTimesModel?> getLastAvailablePrayerTimes(String city) async {
    final prefs = await SharedPreferences.getInstance();
    
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
  final prefs = await SharedPreferences.getInstance();
  final dateString = date.toString().substring(0, 10);
  final key = 'prayerTimes_${dateString}_$city';
  final jsonString = jsonEncode(timings);
  await prefs.setString(key, jsonString);
}

}
