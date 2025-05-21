import 'package:flutter/material.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/models/audio_mobel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quran_app/presentation/main/home/widgets/logic_methods.dart';

class SurahDetailProvider with ChangeNotifier {
  List<AyahModel> ayahs = [];
  List<AudioModel> reciters = [];
  bool isLoading = true;
  final player = AudioPlayer();
  AudioModel? selectedReciter;
  bool isPlaying = false;

  SurahDetailProvider() {
    player.onPlayerComplete.listen((event) {
      isPlaying = false;
      notifyListeners();
    });
  }

  Future<void> loadData(int surahNumber) async {
    isLoading = true;
    notifyListeners();

    ayahs = await LogicMethods.fetchAyahs(surahNumber);
    reciters = await LogicMethods.fetchReciters();
    selectedReciter = reciters.isNotEmpty ? reciters.first : null;

    isLoading = false;
    notifyListeners();
  }

  Future<void> playFullSurah(int surahNumber) async {
    if (selectedReciter == null) return;

    final audioModel = await LogicMethods.fetchSurahAudio(
      selectedReciter!.reciterId,
      surahNumber,
    );

    if (audioModel != null && audioModel.audioUrl.isNotEmpty) {
      final localPath = await LogicMethods.getOrDownloadAudio(
        audioModel.audioUrl,
        '${surahNumber}_${selectedReciter!.reciterId}.mp3',
      );
      await player.play(DeviceFileSource(localPath));
      isPlaying = true;
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

  void disposePlayer() {
    player.dispose();
  }
}
