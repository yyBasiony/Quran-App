import 'package:flutter/material.dart';
import '../../../data/models/surah_model.dart';
import 'surahs_usecase.dart';

class SurahProvider extends ChangeNotifier {
  final SurahsUseCase _surahsUseCase;

  SurahProvider(this._surahsUseCase);

  List<SurahModel> _surahs = [];
  List<SurahModel> _filteredSurahs = [];
  bool _isLoading = true;
  String? errorMessage;

  bool _isDisposed = false;

  List<SurahModel> get surahs => _filteredSurahs;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void safeNotifyListeners() {
    if (!_isDisposed) notifyListeners();
  }

  Future<void> fetchSurahs() async {
    _isLoading = true;
    safeNotifyListeners();
    try {
      final result = await _surahsUseCase.execute();
      _surahs = result;
      _filteredSurahs = result;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      _surahs = [];
      _filteredSurahs = [];
    }
    _isLoading = false;
    safeNotifyListeners();
  }

  void filterSurahs(String query) {
    final normalizedQuery = _removeDiacritics(query.toLowerCase().trim());
    _filteredSurahs = _surahs.where((surah) {
      final arabicName = _removeDiacritics(surah.name.toLowerCase().trim());
      final englishName = surah.englishName.toLowerCase().trim();
      return arabicName.contains(normalizedQuery) || englishName.contains(normalizedQuery);
    }).toList();
    safeNotifyListeners();
  }

  String _removeDiacritics(String text) {
    return text.replaceAll(RegExp(r'[\u064B-\u065F\u0610-\u061A\u06D6-\u06ED]'), '');
  }

  void clearMessages() {
    errorMessage = null;
    safeNotifyListeners();
  }
}
