import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/prayer_times_model.dart';
import '../../services/prayer_times_service.dart';
import '../presentation/main/home/widgets/logic_methods.dart';

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
    fetchPrayerTimes(); 
  }

  void changeCity(String city) {
    _selectedCity = city;
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    final times = await LogicMethods.fetchPrayerTimes(_prayerService, _selectedCity);
    if (times != null) {
      _prayerTimes = times;
      var nextPrayerData = LogicMethods.getNextPrayerTime(times);
      _nextPrayer = nextPrayerData["name"]!;
      _nextPrayerTime = nextPrayerData["time"]!;
      notifyListeners();
    }
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
