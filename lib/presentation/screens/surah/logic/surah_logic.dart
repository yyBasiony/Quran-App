
import '../../../../data/models/audio_mobel.dart';
import '../../../../data/models/ayah_model.dart';
import '../../../../data/models/surah_model.dart';
import '../../../../data/services/audio/audio_service.dart';
import '../../../../data/services/quran/ayah_service.dart';
import '../../../../data/services/quran/surah_service.dart';

class SurahLogic {
  static  final AyahService _ayahService = AyahService();
    static  final SurahService _surahService = SurahService();
  static final AudioService _audioService = AudioService();

  static Future<List<SurahModel>> fetchSurahs() async {
    return await _surahService.fetchSurahs(); 
  }

  static String removeDiacritics(String text) {
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

  static Future<List<AyahModel>> fetchAyahs(int surahNumber) async {
    return await _ayahService.fetchSurahAyahs(surahNumber);
  }

  static Future<List<AudioModel>> fetchReciters() async {
    return await _audioService.fetchReciters();
  }

  static Future<List<AudioModel>> fetchRecitersWithSurah(int surahNumber) async {
    return await _audioService.fetchRecitersWithSurah(surahNumber);
  }

  static Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    return await _audioService.fetchSurahAudio(reciterId, surahNumber);
  }

  // static Future<String> getOrDownloadAudio(String url, String fileName) async {
  //   return await _audioService.AudioDownloader(url, fileName);
  // }
}
