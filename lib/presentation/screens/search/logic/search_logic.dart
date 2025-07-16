import 'package:qanet/data/models/search_ayah_model.dart';
import 'package:qanet/data/services/quran_service.dart';

class SearchLogic {
  static Future<List<SearchAyahModel>> search(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final results = await QuranService().searchAyah(query);
      return results;
    } catch (e) {
      throw Exception('Error while searching');
    }
  }
}
