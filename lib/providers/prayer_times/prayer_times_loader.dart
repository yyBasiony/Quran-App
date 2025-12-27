import 'package:easy_localization/easy_localization.dart';

import '../../data/connectivity_helper.dart';
import '../../data/services/prayer_times/prayer_times_service.dart';
import '../../data/models/prayer_times_model.dart';

class PrayerTimesLoader {
  final PrayerTimesService _service = PrayerTimesService();

  Future<(PrayerTimesModel?, bool, String?)> loadPrayerTimes(String city) async {
    final hasConnection = await ConnectivityHelper.hasInternet();

    if (!hasConnection) {
      final cached = await _service.getLastAvailablePrayerTimes(city);
      return (
        cached,
        true,
        cached != null ? 'prayerTimesFromCache'.tr() : 'prayerTimesOfflineMessage'.tr()
      );
    }

    try {
      final result = await _service.fetchPrayerTimes(city, "Egypt");
      return (result, false, null);
    } catch (e) {
      return (null, false, e.toString());
    }
  }
}
