import 'dart:convert';
import '../../../app/app_preferences.dart';

class ReciterCacheService {
  static Future<void> cacheReciters(int surahNumber, List<Map<String, dynamic>> reciters) async {
    final prefs = AppPreferences.prefs;
    final key = 'reciters_surah_$surahNumber';
    final jsonString = jsonEncode(reciters);
    await prefs.setString(key, jsonString);
  }

  static Future<List<Map<String, dynamic>>> getCachedReciters(int surahNumber) async {
    final prefs = AppPreferences.prefs;
    final key = 'reciters_surah_$surahNumber';
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
      }
    }
    return [];
  }
}




