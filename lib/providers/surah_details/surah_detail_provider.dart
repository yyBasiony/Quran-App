import 'package:flutter/material.dart';
import '../../../data/models/ayah_model.dart';
import '../../../data/models/audio_mobel.dart';
import 'surah_audio_manager.dart';
import 'surah_content_loader.dart';

class SurahDetailProvider with ChangeNotifier {
  final SurahContentLoader _surahContent = SurahContentLoader();
  final SurahAudioManager _audioManager = SurahAudioManager();

  List<AyahModel> ayahs = [];
  List<AudioModel> reciters = [];
  AudioModel? selectedReciter;
  bool isLoading = true, hasFailedToLoad = false, isPlaying = false, isDownloading = false, _isDisposed = false;
  String? errorMessage;

  SurahDetailProvider() {
    _audioManager.setOnCompleteListener(() {
      if (_isDisposed) return;
      isPlaying = false;
      safeNotifyListeners();
    });
  }
  Future<void> loadData(int surahNumber) async {
    isLoading = true;
    // hasFailedToLoad = false;
    // errorMessage = null;
    safeNotifyListeners();

    final result = await _surahContent.loadSurahData(surahNumber);

    ayahs = result.ayahs;
    reciters = result.reciters;
    selectedReciter = reciters.isNotEmpty ? reciters.first : null;

    hasFailedToLoad = result.hasFailed;
    errorMessage = result.errorMessage;

    isLoading = false;
    safeNotifyListeners();
  }

  Future<void> playFullSurah(int surahNumber) async {
    if (_isDisposed || selectedReciter == null) return;
    isDownloading = true;
    errorMessage = null;
    safeNotifyListeners();

    final result = await _audioManager.playSurah(surahNumber, selectedReciter!);
    isDownloading = false;
    isPlaying = result.success;
    errorMessage = result.errorMessage;
    safeNotifyListeners();
  }

  void pauseAudio() async {
    if (_isDisposed) return;
    await _audioManager.pause();
    isPlaying = false;
    safeNotifyListeners();
  }

  void changeReciter(AudioModel reciter) {
    if (_isDisposed) return;
    selectedReciter = reciter;
    safeNotifyListeners();
  }

  void clearMessages() {
    errorMessage = null;
    safeNotifyListeners();
  }

  void disposePlayer() => _audioManager.dispose();
  void safeNotifyListeners() {
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    disposePlayer();
    super.dispose();
  }
}
