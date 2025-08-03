import '../../../presentation/resources/hive_box_names.dart';
import '../../models/audio_info.dart';
import '../hive_chach_services.dart';

class AudioCacheService {
  static final _cache = HiveCacheService(HiveBoxNames.audioInfoBox);

  static Future<void> saveAudioInfo(AudioInfo info) async {
    final key = 'audio_${info.surahNumber}_${info.reciterId}';
    await _cache.saveData(key, info.toJson());
  }

  static Future<AudioInfo?> getSavedAudioInfo({
    required int surahNumber,
    required int reciterId,
  }) async {
    final key = 'audio_${surahNumber}_${reciterId}';
    final data = await _cache.getData(key);
    if (data != null) {
      return AudioInfo.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }
}
