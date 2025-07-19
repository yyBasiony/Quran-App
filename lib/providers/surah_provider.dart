import 'package:flutter/material.dart';
import 'package:qanet/data/connectivity_helper.dart';
import 'package:qanet/presentation/screens/surah/logic/surah_logic.dart';
import 'package:qanet/data/models/surah_model.dart';

class SurahProvider extends ChangeNotifier {
  List<SurahModel> _surahs = [];
  List<SurahModel> _filteredSurahs = [];
  bool _isLoading = true;
  BuildContext? _context;

  List<SurahModel> get surahs => _filteredSurahs;
  bool get isLoading => _isLoading;

  void setContext(BuildContext context) {
    _context = context;
  }

  SurahProvider() {
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      if (_context != null) {
        final hasInternet = await ConnectivityHelper.hasInternet();
        if (!hasInternet) {
          ConnectivityHelper.showNoInternetSnackBar(
            _context!,
customMessage: 'An internet connection is required to load the list of surahs for the first time'
          );
          _surahs = [];
          _filteredSurahs = [];
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
      
      _surahs = await SurahLogic.fetchSurahs(context: _context);
      _filteredSurahs = _surahs;
    } catch (e) {
      //print('Error fetching surahs: $e');
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
