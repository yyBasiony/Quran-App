import 'package:hive/hive.dart';

class AudioCacheService {
  static Future<void> saveAudioInfo({
    required int surahNumber,
    required int reciterId,
    required String audioUrl,
    required String reciterName,
  }) async {
    final box = await Hive.openBox('audioInfoBox');
    final key = 'audio_${surahNumber}_${reciterId}';
    await box.put(key, {
      'audioUrl': audioUrl,
      'reciterName': reciterName,
      'surahNumber': surahNumber,
      'reciterId': reciterId,
    });
  }

  static Future<Map<String, dynamic>?> getSavedAudioInfo({
    required int surahNumber,
    required int reciterId,
  }) async {
    final box = await Hive.openBox('audioInfoBox');
    final key = 'audio_${surahNumber}_${reciterId}';
    return box.get(key);
  }
}
