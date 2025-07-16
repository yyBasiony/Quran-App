import 'package:qanet/data/models/audio_mobel.dart';
import 'package:qanet/data/models/ayah_model.dart';
import 'package:qanet/data/models/surah_model.dart';
import 'package:qanet/data/services/audio_service.dart';
import 'package:qanet/data/services/quran_service.dart';

class SurahLogic {
  static final QuranService _quranService = QuranService();

  static Future<List<SurahModel>> fetchSurahs() async {
    return await _quranService.fetchSurahs();
  }
static String removeDiacritics(String text) {
  // Remove Arabic diacritics
  return text.replaceAll(RegExp(r'[\u064B-\u065F\u0610-\u061A\u06D6-\u06ED]'), '');
}

static List<SurahModel> filterSurahs(List<SurahModel> surahs, String query) {
  final normalizedQuery = removeDiacritics(query.toLowerCase().trim());

  return surahs.where((surah) {
    final arabicName = removeDiacritics(surah.name.toLowerCase().trim());
    final englishName = surah.englishName.toLowerCase().trim();

    return arabicName.contains(normalizedQuery) || englishName.contains(normalizedQuery);
  }).toList();
}
  //surah details
    static Future<List<AyahModel>> fetchAyahs(int surahNumber) async {
    return await QuranService().fetchSurahAyahs(surahNumber);
  }

   static Future<List<AudioModel>> fetchReciters() async {
     return await AudioService().fetchReciters();
   }
static Future<List<AudioModel>> fetchRecitersWithSurah(int surahNumber) async {
  return await AudioService().fetchRecitersWithSurah(surahNumber);
}
   

   

 static Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    return await AudioService().fetchSurahAudio(reciterId, surahNumber);
  }

  static Future<String> getOrDownloadAudio(String url, String fileName) async {
    return await AudioService().getOrDownloadAudio(url, fileName);
  }

}
