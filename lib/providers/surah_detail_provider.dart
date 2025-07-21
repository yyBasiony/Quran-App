import 'package:flutter/material.dart';
import 'package:qanet/data/models/ayah_model.dart';
import 'package:qanet/data/models/audio_mobel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:qanet/presentation/screens/surah/logic/surah_logic.dart';
import 'package:qanet/data/connectivity_helper.dart';

class SurahDetailProvider with ChangeNotifier {
  List<AyahModel> ayahs = [];
  List<AudioModel> reciters = [];
  bool isLoading = true;
  bool hasFailedToLoad = false;
  final player = AudioPlayer();
  AudioModel? selectedReciter;
  bool isPlaying = false;

  String? errorMessage;

  SurahDetailProvider() {
    player.onPlayerComplete.listen((event) {
      isPlaying = false;
      notifyListeners();
    });
  }

  Future<void> loadData(int surahNumber) async {
    isLoading = true;
    hasFailedToLoad = false;
    errorMessage = null;
    notifyListeners();

    try {
      final hasInternet = await ConnectivityHelper.hasInternet();
      if (!hasInternet) {
        hasFailedToLoad = true;
        errorMessage = 'noInternetMessage';
        isLoading = false;
        notifyListeners();
        return;
      }

      ayahs = await SurahLogic.fetchAyahs(surahNumber);
      reciters = await SurahLogic.fetchRecitersWithSurah(surahNumber);

      if (reciters.isNotEmpty) {
        selectedReciter = reciters.first;
      } else {
        selectedReciter = null;
      }

      hasFailedToLoad = false;
    } catch (e) {
      hasFailedToLoad = true;
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> playFullSurah(int surahNumber) async {
    if (selectedReciter == null) return;

    try {
      final audioModel = await SurahLogic.fetchSurahAudio(
        selectedReciter!.reciterId,
        surahNumber,
      );

      if (audioModel == null || audioModel.audioUrl.isEmpty) {
        errorMessage = 'audioNotAvailable';
        notifyListeners();
        return;
      }

      final fileName = '${surahNumber}_${selectedReciter!.reciterId}.mp3';
      await player.play(UrlSource(audioModel.audioUrl));
      isPlaying = true;
      notifyListeners();

SurahLogic.getOrDownloadAudio(audioModel.audioUrl, fileName)
  .catchError((e) {
    errorMessage = 'downloadFailed';
    notifyListeners();
    return '';
  });
    } catch (e) {
      errorMessage = 'playbackError';
      notifyListeners();
    }
  }

  void pauseAudio() async {
    await player.pause();
    isPlaying = false;
    notifyListeners();
  }

  void changeReciter(AudioModel newReciter) {
    selectedReciter = newReciter;
    notifyListeners();
  }

  void clearMessages() {
    errorMessage = null;
    notifyListeners();
  }

  void disposePlayer() {
    player.dispose();
  }
}
