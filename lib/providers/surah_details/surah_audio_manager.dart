import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../data/models/audio_mobel.dart';
import '../../../data/services/audio/audio_cache_service.dart';
import '../../../data/services/audio/audio_downloader.dart';
import '../../../data/services/audio/audio_service.dart';
import '../../data/connectivity_helper.dart';

class AudioPlayResult {
  final bool success;
  final String? errorMessage;

  AudioPlayResult({required this.success, this.errorMessage});
}

class SurahAudioManager {
  AudioPlayer? _player = AudioPlayer();
  final AudioService _audioService = AudioService();

  void setOnCompleteListener(void Function() onComplete) {
    _player?.onPlayerComplete.listen((event) => onComplete());
  }

  Future<AudioPlayResult> playSurah(int surahNumber, AudioModel reciter) async {
    if (_player == null) {
      return AudioPlayResult(success: false, errorMessage: 'Player is disposed');
    }

    try {
      final fileName = 'surah_${surahNumber}_reciter_${reciter.reciterId}.mp3';
      final dir = await getApplicationDocumentsDirectory();
      final localPath = '${dir.path}/quran_audio/$fileName';

      final isDownloaded = await AudioDownloader.isAudioDownloaded(fileName);

      if (isDownloaded) {
        await _player!.play(DeviceFileSource(localPath));
        return AudioPlayResult(success: true);
      }

      final hasInternet = await ConnectivityHelper.hasInternet();
      if (!hasInternet) {
        return AudioPlayResult(success: false, errorMessage: 'no_internet_message'.tr());
      }

      final audioModel = await _audioService.fetchSurahAudio(reciter.reciterId, surahNumber);
      if (audioModel == null || audioModel.audioUrl.isEmpty) {
        return AudioPlayResult(success: false, errorMessage: 'audio_url_unavailable'.tr());
      }

      await AudioCacheService.saveAudioInfo(
        surahNumber: surahNumber,
        reciterId: reciter.reciterId,
        audioUrl: audioModel.audioUrl,
        reciterName: reciter.reciterName,
      );

      await _player!.play(UrlSource(audioModel.audioUrl));

      AudioDownloader.getOrDownloadAudio(audioModel.audioUrl, fileName);

      return AudioPlayResult(success: true);
    } catch (e) {
      return AudioPlayResult(success: false, errorMessage: e.toString());
    }
  }

  Future<void> pause() async {
    if (_player != null) {
      await _player!.pause();
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
  }
}
