import 'dart:async';
import 'package:intl/intl.dart';

import '../../../../models/audio_mobel.dart';
import '../../../../models/ayah_model.dart';
import '../../../../models/prayer_times_model.dart';
import '../../../../services/audio_service.dart';
import '../../../../services/prayer_times_service.dart';
import '../../../../services/quran_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LogicMethods {
static Future<PrayerTimesModel?> fetchPrayerTimes(
    PrayerTimesService service, String city) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = 'prayerTimes_${DateTime.now().toString().substring(0, 10)}_$city';
//if there are local data return it
    if (prefs.containsKey(todayKey)) {
      final cachedData = prefs.getString(todayKey);
      if (cachedData != null) {
        final timingsMap = jsonDecode(cachedData);
        return PrayerTimesModel.fromJson(timingsMap);
      }
    }
//if no  get from api
    final times = await service.fetchPrayerTimes(city, "Egypt");
//save it in  shared preferences
    final timingsJson = jsonEncode({
      "Fajr": times.fajr,
      "Dhuhr": times.dhuhr,
      "Asr": times.asr,
      "Maghrib": times.maghrib,
      "Isha": times.isha,
    });
    await prefs.setString(todayKey, timingsJson);

    return times;
  } catch (e) {
    print('Error fetching prayer times: $e');
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
  //surah details
    static Future<List<AyahModel>> fetchAyahs(int surahNumber) async {
    return await QuranService().fetchSurahAyahs(surahNumber);
  }

  static Future<List<AudioModel>> fetchReciters() async {
    return await AudioService().fetchReciters();
  }
    static Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    return await AudioService().fetchSurahAudio(reciterId, surahNumber);
  }

  static Future<String> getOrDownloadAudio(String url, String fileName) async {
    return await AudioService().getOrDownloadAudio(url, fileName);
  }


}

