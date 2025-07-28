import 'package:qanet/data/models/search_ayah_model.dart';

import '../../../../data/services/quran/search_service.dart';

class SearchLogic {
  static Future<List<SearchAyahModel>> search(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final results = await SearchService().searchAyah(query);
      return results;
    } catch (e) {
      throw Exception('Error while searching');
    }
  }
}
