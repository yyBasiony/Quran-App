import '../../models/prayer_times_model.dart';
import '../shared_prefs_cache_services.dart';

class PrayerTimesCache {
  static final _cache = SharedPrefsCacheService();

  static Future<PrayerTimesModel?> getLastAvailablePrayerTimes(String city) async {
    for (int i = 0; i < 7; i++) {
      final date = DateTime.now().subtract(Duration(days: i));
      final dateString = date.toString().substring(0, 10);
      final key = 'prayerTimes_${dateString}_$city';

      final data = await _cache.getData(key);
      if (data != null) {
        return PrayerTimesModel.fromJson(data);
      }
    }
    return null;
  }

  static Future<void> savePrayerTimes(String city, DateTime date, Map<String, dynamic> timings) async {
    final dateString = date.toString().substring(0, 10);
    final key = 'prayerTimes_${dateString}_$city';
    await _cache.saveData(key, timings);
  }
}
