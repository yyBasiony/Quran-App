import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart'; 
import 'package:qanet/data/models/search_ayah_model.dart';
import '../../data/services/quran/search_service.dart';

class SearchProvider with ChangeNotifier {
  final SearchService _searchService;

  SearchProvider(this._searchService);

  List<SearchAyahModel> searchResults = [];
  bool isLoading = false;
  String errorMessage = '';
  factory SearchProvider.withDependencies() {
    return SearchProvider(SearchService());
  }

  void onSearchPressed(String query) {
    searchAyahs(query);
  }

  Future<void> searchAyahs(String query) async {
    if (query.trim().isEmpty) return;
    isLoading = true;
    errorMessage = '';
    searchResults = [];
    notifyListeners();

    try {
      final results = await _searchService.searchAyah(query);
      searchResults = results;
    } catch (e) {
      errorMessage = 'An error occurred during the search.'.tr();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
