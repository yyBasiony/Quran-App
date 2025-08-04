import 'package:hive/hive.dart';
import 'package:qanet/providers/surah_details/surah_content_result.dart';

import '../../../data/models/audio_mobel.dart';
import '../../../data/services/quran/ayah_service.dart';
import '../../../data/services/audio/audio_service.dart';
import '../../../data/services/audio/reciter_cache_service.dart';
import '../../data/connectivity_helper.dart';
import '../../data/services/exceptions.dart';

class SurahContentLoader {
  final AyahService _ayahService = AyahService();
  final AudioService _audioService = AudioService();

  Future<SurahContentResult> loadSurahData(int surahNumber) async {
    try {
      final ayahs = await _ayahService.fetchSurahAyahs(surahNumber);
      final cached = await ReciterCacheService.getCachedReciters(surahNumber);

      List<AudioModel> reciters = cached.map((e) => AudioModel.fromJson(e, surahNumber)).toList();

      try {
        final online = await _audioService.fetchRecitersWithSurah(surahNumber);
        if (online.isNotEmpty) {
          reciters = online;
          final box = await Hive.openBox('recitersBox');
          await box.put('reciters_surah_$surahNumber', online.map((e) => e.toJson()).toList());
        }
      } catch (_) {
      }

      final hasInternet = await ConnectivityHelper.hasInternet();
      if (!hasInternet && ayahs.isEmpty) {
        throw NoInternetException();
      }

      return SurahContentResult(
        ayahs: ayahs,
        reciters: reciters,
        hasFailed: false,
      );
    } on AppException catch (e) {
      return SurahContentResult(
        ayahs: [],
        reciters: [],
        hasFailed: true,
        errorMessage: e.message,
      );
    } catch (e) {
      return SurahContentResult(
        ayahs: [],
        reciters: [],
        hasFailed: true,
        errorMessage: UnknownException().message,
      );
    }
  }
}
