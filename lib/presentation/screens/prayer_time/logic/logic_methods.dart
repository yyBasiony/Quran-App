import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qanet/data/connectivity_helper.dart';
import '../../../../data/models/prayer_times_model.dart';
import '../../../../data/services/prayer_times_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LogicMethods {
  static Future<PrayerTimesModel?> fetchPrayerTimes(PrayerTimesService service, String city, {BuildContext? context}) async {
    final prefs = await SharedPreferences.getInstance();
    final todayKey = 'prayerTimes_${DateTime.now().toString().substring(0, 10)}_$city';

    if (prefs.containsKey(todayKey)) {
      final cachedData = prefs.getString(todayKey);
      if (cachedData != null) {
        final timingsMap = jsonDecode(cachedData);
        return PrayerTimesModel.fromJson(timingsMap);
      }
    }

    final hasInternet = await ConnectivityHelper.hasInternet();
    if (!hasInternet) {
      final lastAvailable = await _getLastAvailablePrayerTimes(prefs, city);
      if (lastAvailable != null) {
        if (context != null) {
          ConnectivityHelper.showCacheDataSnackBar(context, 'No internet connection. Displaying the last saved prayer times.');
        }
        return lastAvailable;
      } else {
        if (context != null) {
          ConnectivityHelper.showNoInternetSnackBar(context, customMessage: 'No internet connection and no saved prayer times available.');
        }
        return null;
      }
    }

    try {
      final times = await service.fetchPrayerTimes(city, "Egypt");

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

      final lastAvailable = await _getLastAvailablePrayerTimes(prefs, city);
      if (lastAvailable != null) {
        if (context != null) {
          ConnectivityHelper.showCacheDataSnackBar(context, 'Failed to update prayer times. Displaying the last saved times.');
        }
        return lastAvailable;
      } else {
        if (context != null) {
          ConnectivityHelper.showNoInternetSnackBar(context, customMessage: 'Failed to fetch prayer times.');
        }
        return null;
      }
    }
  }

  static Future<PrayerTimesModel?> _getLastAvailablePrayerTimes(SharedPreferences prefs, String city) async {
    for (int i = 1; i < 8; i++) {
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
