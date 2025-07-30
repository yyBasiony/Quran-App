import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/prayer_times_model.dart';
import 'prayer_times_updater.dart';
import 'selected_city_manager.dart';
import 'prayer_times_loader.dart';

class PrayerTimesProvider with ChangeNotifier {
  final PrayerTimesLoader _loader = PrayerTimesLoader();

  PrayerTimesModel? _prayerTimes;
  String _selectedCity = 'Zagazig';
  String _nextPrayer = '';
  String _nextPrayerTime = '';
  String? _statusMessage;
  bool _isFromCache = false;
  bool _hasInternet = true;
  Timer? _timer;
  bool _isDisposed = false;

  String get selectedCity => _selectedCity;
  PrayerTimesModel? get prayerTimes => _prayerTimes;
  String get nextPrayer => _nextPrayer;
  String get nextPrayerTime => _nextPrayerTime;
  String? get statusMessage => _statusMessage;
  bool get isFromCache => _isFromCache;
  bool get hasInternet => _hasInternet;

  PrayerTimesProvider() {
    _init();
  }

  Future<void> _init() async {
    _selectedCity = SelectedCityManager.getSelectedCity();
    await fetchPrayerTimes();
  }

  Future<void> changeCity(String city) async {
    _selectedCity = city;
    await SelectedCityManager.setSelectedCity(city);
    await fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    final (result, fromCache, message) =
        await _loader.loadPrayerTimes(_selectedCity);

    if (result != null) {
      _updateWithModel(result, fromCache: fromCache);
    }

    _statusMessage = message;
    safeNotifyListeners();
    _resetStatusMessage();
  }

  void _updateWithModel(PrayerTimesModel model, {bool fromCache = false}) {
    _prayerTimes = model;
    final (prayer, time) = PrayerTimesUpdater.calculateNextPrayer(model);
    _nextPrayer = prayer;
    _nextPrayerTime = time;
    _isFromCache = fromCache;
    _statusMessage = null;
    safeNotifyListeners();
  }

  void _resetStatusMessage() {
    if (_statusMessage == null || _statusMessage!.isEmpty) return;
    Timer(const Duration(seconds: 5), () {
      if (_isDisposed) return;
      _statusMessage = null;
      safeNotifyListeners();
    });
  }

  void safeNotifyListeners() {
    if (!_isDisposed) notifyListeners();
  }

  void disposeTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _isDisposed = true;
    disposeTimer();
    super.dispose();
  }
}
