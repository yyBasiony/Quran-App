import '../base_service.dart';
import '../../models/prayer_times_model.dart';
import 'prayer_times_cache.dart';

class PrayerTimesService extends BaseService {
  static const String baseUrl = 'https://api.aladhan.com/v1/timingsByCity';

  Future<PrayerTimesModel> fetchPrayerTimes(String city, String country) async {
    final today = DateTime.now();
    final dateString = '${today.day}-${today.month}-${today.year}';
    final url = '$baseUrl/$dateString?country=$country&city=$city';

    final data = await getRequest(url);

    await PrayerTimesCache.savePrayerTimes(city, today, data['data']['timings']);

    return PrayerTimesModel.fromJson(data['data']['timings']);
  }

  Future<PrayerTimesModel?> getLastAvailablePrayerTimes(String city) async {
    return await PrayerTimesCache.getLastAvailablePrayerTimes(city);
  }
}
