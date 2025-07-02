import 'package:flutter/material.dart';
import 'package:qanet/core/utils/surah_logic.dart';
import 'package:qanet/data/models/surah_model.dart';

class SurahProvider extends ChangeNotifier {
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

      _surahs = await SurahLogic.fetchSurahs();
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
    _filteredSurahs = SurahLogic.filterSurahs(_surahs, query);
    notifyListeners();
  }
}
