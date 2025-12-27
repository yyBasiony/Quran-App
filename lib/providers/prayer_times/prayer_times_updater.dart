import 'package:intl/intl.dart';
import '../../data/models/prayer_times_model.dart';

class PrayerTimesUpdater {
  static (String, String) calculateNextPrayer(PrayerTimesModel model) {
    final now = DateTime.now();
    final prayers = {
      "Fajr": model.fajr,
      "Dhuhr": model.dhuhr,
      "Asr": model.asr,
      "Maghrib": model.maghrib,
      "Isha": model.isha,
    };

    for (var entry in prayers.entries) {
      final time = _parseTime(entry.value);
      if (time != null && now.isBefore(time)) {
        return (entry.key, entry.value);
      }
    }
    return ("Fajr", prayers["Fajr"]!);
  }

  static DateTime? _parseTime(String time) {
    try {
      final now = DateTime.now();
      final parsed = DateFormat("HH:mm").parse(time);
      return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
    } catch (_) {
      return null;
    }
  }
}

