import '../../models/search_ayah_model.dart';
import '../base_service.dart';

class SearchService extends BaseService {
  Future<List<SearchAyahModel>> searchAyah(String searchText) async {
    final data = await getRequest('https://api-quran.com/api?text=$searchText&type=search');
    print('API response: $data');

    if (data.containsKey('result') && data['result'] is List) {
      return (data['result'] as List).whereType<String>().map((text) => SearchAyahModel(text: text)).toList();
    }
    return [];
  }
}
