import '../../models/audio_mobel.dart';
import '../base_service.dart';
import 'package:qanet/data/services/audio/reciter_cache_service.dart';

class AudioService extends BaseService {
  static const String baseUrl = 'https://mp3quran.net/api/v3';

  Future<List<AudioModel>> fetchReciters() async {
    final recitersJson = await getListRequest('$baseUrl/reciters', 'reciters');
    return recitersJson.map((reciter) => AudioModel.fromJson(reciter, 1)).toList();
  }

  Future<List<AudioModel>> fetchRecitersWithSurah(int surahNumber) async {
    try {
      final cachedData = await ReciterCacheService.getCachedReciters(surahNumber);
      if (cachedData.isNotEmpty) {
        return cachedData.map((reciter) => AudioModel.fromJson(reciter, surahNumber)).toList();
      }
    } catch (_) {}

    try {
      final recitersJson = await getListRequest('$baseUrl/reciters', 'reciters');

      final filtered = recitersJson.where((reciter) {
        final moshafList = reciter['moshaf'] as List<dynamic>?;
        if (moshafList == null || moshafList.isEmpty) return false;

        return moshafList.any((moshaf) {
          final surahList = moshaf['surah_list'];
          if (surahList == null) return false;
          final surahs = surahList.toString().split(',').map((e) => e.trim());
          return surahs.contains(surahNumber.toString());
        });
      }).toList();

      await ReciterCacheService.cacheReciters(
        surahNumber,
        filtered.map((e) => Map<String, dynamic>.from(e)).toList(),
      );

      return filtered.map((reciter) => AudioModel.fromJson(Map<String, dynamic>.from(reciter), surahNumber)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    final recitersJson = await getListRequest('$baseUrl/reciters', 'reciters');
    final reciter = recitersJson.firstWhere((r) => r['id'] == reciterId, orElse: () => {});
    if (reciter.isNotEmpty && reciter.containsKey('moshaf')) {
      return AudioModel.fromJson(reciter, surahNumber);
    }
    return null;
  }
}
