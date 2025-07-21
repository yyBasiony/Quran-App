import 'package:flutter/material.dart';
import 'package:qanet/data/connectivity_helper.dart';
import 'package:qanet/presentation/screens/surah/logic/surah_logic.dart';
import 'package:qanet/data/models/surah_model.dart';

class SurahProvider extends ChangeNotifier {
  List<SurahModel> _surahs = [];
  List<SurahModel> _filteredSurahs = [];
  bool _isLoading = true;
  String? errorMessage;

  List<SurahModel> get surahs => _filteredSurahs;
  bool get isLoading => _isLoading;

  SurahProvider() {
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      _isLoading = true;
      notifyListeners();

      final hasInternet = await ConnectivityHelper.hasInternet();
      if (!hasInternet) {
        errorMessage = 'noInternetMessage';
        _surahs = [];
        _filteredSurahs = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      _surahs = await SurahLogic.fetchSurahs();
      _filteredSurahs = _surahs;
      errorMessage = null;
    } catch (e) {
      _surahs = [];
      _filteredSurahs = [];
      errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterSurahs(String query) {
    _filteredSurahs = SurahLogic.filterSurahs(_surahs, query);
    notifyListeners();
  }
  void clearMessages() {
  errorMessage = null;
  notifyListeners();
}

}
