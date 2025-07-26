import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/prayer_times_model.dart';
import 'base_service.dart';

class PrayerTimesService extends BaseService {
  static const String baseUrl = 'https://api.aladhan.com/v1/timingsByCity';

  Future<PrayerTimesModel> fetchPrayerTimes(String city, String country) async {
    final today = DateTime.now();
    final dateString = '${today.day}-${today.month}-${today.year}';
    final url = '$baseUrl/$dateString?country=$country&city=$city';

    final data = await getRequest(url);
    return PrayerTimesModel.fromJson(data['data']['timings']);
  }

  Future<PrayerTimesModel?> getLastAvailablePrayerTimes(String city) async {
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
}
