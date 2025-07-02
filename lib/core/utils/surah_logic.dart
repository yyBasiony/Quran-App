import 'package:qanet/data/models/surah_model.dart';
import 'package:qanet/data/services/quran_service.dart';

class SurahLogic {
  static final QuranService _quranService = QuranService();

  static Future<List<SurahModel>> fetchSurahs() async {
    return await _quranService.fetchSurahs();
  }

  static List<SurahModel> filterSurahs(List<SurahModel> surahs, String query) {
    return surahs.where((surah) {
      return surah.englishName.toLowerCase().contains(query.toLowerCase()) ||
          surah.name.contains(query);
    }).toList();
  }
}
