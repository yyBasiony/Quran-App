import 'package:qanet/data/services/audio/reciter_cache_service.dart';

class AudioCacheHelper {
  static Future<List<Map<String, dynamic>>> getFromCache(int surahNumber) async {
    try {
      return await ReciterCacheService.getCachedReciters(surahNumber);
    } catch (_) {
      return [];
    }
  }

  static Future<void> saveToCache(int surahNumber, List<dynamic> filteredReciters) async {
    final casted = filteredReciters.map((e) => Map<String, dynamic>.from(e)).toList();
    await ReciterCacheService.cacheReciters(surahNumber, casted);
  }
}
