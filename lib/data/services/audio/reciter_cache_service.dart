import '../shared_prefs_cache_services.dart';

class ReciterCacheService {
  static final _cache = SharedPrefsCacheService();

  static Future<void> cacheReciters(int surahNumber, List<Map<String, dynamic>> reciters) async {
    final key = 'reciters_surah_$surahNumber';
    await _cache.saveData(key, reciters);
  }

  static Future<List<Map<String, dynamic>>> getCachedReciters(int surahNumber) async {
    final key = 'reciters_surah_$surahNumber';
    final data = await _cache.getData(key);
    if (data is List) {
      return data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }
}
