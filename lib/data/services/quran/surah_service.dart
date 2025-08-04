import 'package:hive/hive.dart';

import '../../models/surah_model.dart';
import '../base_service.dart';
import 'i_surah_service.dart';

class SurahService extends BaseService implements ISurahService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  @override
  Future<List<SurahModel>> fetchSurahs() async {
    final box = await Hive.openBox<SurahModel>('surahsBox');
    if (box.isNotEmpty) return box.values.toList();

    final data = await getRequest('$baseUrl/surah');
    final surahs = (data['data'] as List)
        .map((json) => SurahModel.fromJson(json))
        .toList();

    for (var surah in surahs) {
      box.put(surah.number, surah);
    }

    return surahs;
  }
}
