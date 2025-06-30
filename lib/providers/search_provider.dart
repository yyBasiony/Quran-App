import 'package:flutter/material.dart';
import 'package:qanet/data/models/search_ayah_model.dart';
import 'package:qanet/data/services/quran_service.dart';

class SearchProvider with ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  List<SearchAyahModel> searchResults = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> searchAyahs(String query) async {
    if (query.trim().isEmpty) return;

    isLoading = true;
    errorMessage = '';
    searchResults = [];
    notifyListeners();

    try {
      final results = await QuranService().searchAyah(query);
      searchResults = results;
    } catch (e) {
      errorMessage = 'حدث خطأ أثناء البحث';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
