import 'package:flutter/material.dart';
import 'package:qanet/models/ayah_model.dart';
import 'package:qanet/models/audio_mobel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:qanet/presentation/main/home/widgets/logic_methods.dart';

class SurahDetailProvider with ChangeNotifier {
  List<AyahModel> ayahs = [];
  List<AudioModel> reciters = [];
  bool isLoading = true;
  final player = AudioPlayer();
  AudioModel? selectedReciter;
  bool isPlaying = false;

  BuildContext? context;

  SurahDetailProvider() {
    player.onPlayerComplete.listen((event) {
      isPlaying = false;
      notifyListeners();
    });
  }

  void setContext(BuildContext context) {
    context = context;
  }

  Future<void> loadData(int surahNumber) async {
    isLoading = true;
    notifyListeners();

    ayahs = await LogicMethods.fetchAyahs(surahNumber);

    reciters = await LogicMethods.fetchRecitersWithSurah(surahNumber);

    if (reciters.isNotEmpty) {
      selectedReciter = reciters.first;
    } else {
      selectedReciter = null;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> playFullSurah(int surahNumber) async {
    if (selectedReciter == null) return;

    try {
      final audioModel = await LogicMethods.fetchSurahAudio(
        selectedReciter!.reciterId,
        surahNumber,
      );

      // if (audioModel == null || audioModel.audioUrl.isEmpty) {
      //   _showAudioNotFoundMessage();
      //   return;
      // }

      final localPath = await LogicMethods.getOrDownloadAudio(
        audioModel!.audioUrl,
        '${surahNumber}_${selectedReciter!.reciterId}.mp3',
      );

      await player.play(DeviceFileSource(localPath));
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      print(" خطأ أثناء تشغيل التلاوة: $e");

      // _showAudioNotFoundMessage();
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

  // void _showAudioNotFoundMessage() {
  //   if (_context != null) {
  //     ScaffoldMessenger.of(_context!).showSnackBar(
  //       const SnackBar(
  //         content: Text(" عذرًا، هذه التلاوة غير متوفرة لهذا القارئ."),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   } else {
  //     print(" التلاوة غير متوفرة، ولم يتم تمرير السياق.");
  //   }
  // }
}
