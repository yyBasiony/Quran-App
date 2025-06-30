import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/prayer_times_model.dart';
import '../data/services/prayer_times_service.dart';
import '../core/utils/logic_methods.dart';

class PrayerTimesProvider with ChangeNotifier {
  final PrayerTimesService _prayerService = PrayerTimesService();

  PrayerTimesModel? _prayerTimes;
  String _selectedCity = 'Zagazig';
  String _nextPrayer = "";
  String _nextPrayerTime = "";

  Timer? _timer;

  String get selectedCity => _selectedCity;
  PrayerTimesModel? get prayerTimes => _prayerTimes;
  String get nextPrayer => _nextPrayer;
  String get nextPrayerTime => _nextPrayerTime;

  PrayerTimesProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadSavedCity();
    fetchPrayerTimes();
  }

  Future<void> _loadSavedCity() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedCity = prefs.getString('selected_city') ?? _selectedCity;
    notifyListeners();
  }

  Future<void> changeCity(String city) async {
    _selectedCity = city;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_city', city);
    fetchPrayerTimes();
    notifyListeners();
  }

  Future<void> fetchPrayerTimes() async {
    final times = await LogicMethods.fetchPrayerTimes(_prayerService, _selectedCity);
    if (times != null) {
      _prayerTimes = times;
      final next = LogicMethods.getNextPrayerTime(times);
      _nextPrayer = next["name"] ?? "";
      _nextPrayerTime = next["time"] ?? "";
      notifyListeners();
    }
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
