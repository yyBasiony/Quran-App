import 'dart:async';
import 'package:intl/intl.dart';

import '../../../../models/prayer_times_model.dart';
import '../../../../services/prayer_times_service.dart';

class LogicMethods {
  static Future<PrayerTimesModel?> fetchPrayerTimes(
      PrayerTimesService service, String city) async {
    try {
      return await service.fetchPrayerTimes(city, "Egypt");
    } catch (e) {
      print('Error fetching prayer times: \$e');
      return null;
    }
  }

  static Map<String, String> getNextPrayerTime(PrayerTimesModel times) {
    DateTime now = DateTime.now();
    Map<String, String> prayers = {
      "Fajr": times.fajr,
      "Dhuhr": times.dhuhr,
      "Asr": times.asr,
      "Maghrib": times.maghrib,
      "Isha": times.isha,
    };

    for (var entry in prayers.entries) {
      DateTime? prayerTime = parseTime(entry.value);
      if (prayerTime != null && now.isBefore(prayerTime)) {
        return {"name": entry.key, "time": entry.value};
      }
    }
    return {"name": "Fajr", "time": prayers["Fajr"]!};
  }

  static DateTime? parseTime(String time) {
    try {
      DateTime now = DateTime.now();
      DateTime parsedTime = DateFormat("HH:mm").parse(time);
      return DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);
    } catch (e) {
      return null;
    }
  }
}

