import 'package:flutter/material.dart';
import '../models/surah_model.dart';
import '../services/quran_service.dart';

class SurahProvider extends ChangeNotifier {
  final QuranService _quranService = QuranService();

  List<SurahModel> _surahs = [];
  List<SurahModel> _filteredSurahs = [];
  bool _isLoading = true;

  List<SurahModel> get surahs => _filteredSurahs;
  bool get isLoading => _isLoading;

  SurahProvider() {
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      _isLoading = true;
      notifyListeners();

      _surahs = await _quranService.fetchSurahs();
      _filteredSurahs = _surahs;
    } catch (e) {
      _surahs = [];
      _filteredSurahs = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterSurahs(String query) {
    _filteredSurahs = _surahs.where((surah) {
      return surah.englishName.toLowerCase().contains(query.toLowerCase()) ||
          surah.name.contains(query);
    }).toList();
    notifyListeners();
  }
}
