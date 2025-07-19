import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qanet/app/app_preferences.dart';
import '../data/models/prayer_times_model.dart';
import '../data/services/prayer_times_service.dart';
import '../presentation/screens/prayer_time/logic/logic_methods.dart';

class PrayerTimesProvider with ChangeNotifier {
  final PrayerTimesService _prayerService = PrayerTimesService();
  PrayerTimesModel? _prayerTimes;
  String _selectedCity = 'Zagazig';
  String _nextPrayer = "";
  String _nextPrayerTime = "";
  String? _statusMessage;
  bool _isFromCache = false;
  Timer? _timer;
  BuildContext? _context;

  String get selectedCity => _selectedCity;
  PrayerTimesModel? get prayerTimes => _prayerTimes;
  String get nextPrayer => _nextPrayer;
  String get nextPrayerTime => _nextPrayerTime;
  String? get statusMessage => _statusMessage;
  bool get isFromCache => _isFromCache;

  PrayerTimesProvider() {
    _init();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  Future<void> _init() async {
    await _loadSavedCity();
    fetchPrayerTimes();
  }

  Future<void> _loadSavedCity() async {
    _selectedCity = AppPreferences.getSelectedCity();
    notifyListeners();
  }

  Future<void> changeCity(String city) async {
    _selectedCity = city;
    await AppPreferences.setSelectedCity(city);
    fetchPrayerTimes();
    notifyListeners();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final result = await LogicMethods.fetchPrayerTimes(
        _prayerService,
        _selectedCity,
        context: _context,
      );

      if (result != null) {
        _prayerTimes = result;
        _isFromCache = false;
        _statusMessage = null;

        final next = LogicMethods.getNextPrayerTime(result);
        _nextPrayer = next["name"] ?? "";
        _nextPrayerTime = next["time"] ?? "";
      } else {
        _statusMessage = "Failed to fetch prayer times";
      }

      notifyListeners();

      if (_statusMessage != null) {
        Timer(const Duration(seconds: 5), () {
          _statusMessage = null;
          notifyListeners();
        });
      }
    } catch (e) {
      _statusMessage = e.toString();
      notifyListeners();

      Timer(const Duration(seconds: 5), () {
        _statusMessage = null;
        notifyListeners();
      });
    }
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
