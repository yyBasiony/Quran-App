import '../models/prayer_times_model.dart';
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
}
