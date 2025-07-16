import 'package:flutter/material.dart';
import 'package:qanet/data/models/ayah_model.dart';
import 'package:qanet/data/models/audio_mobel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:qanet/presentation/screens/surah/logic/surah_logic.dart';

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

    ayahs = await SurahLogic.fetchAyahs(surahNumber);

    reciters = await SurahLogic.fetchRecitersWithSurah(surahNumber);

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
    final audioModel = await SurahLogic.fetchSurahAudio(
      selectedReciter!.reciterId,
      surahNumber,
    );

    if (audioModel == null || audioModel.audioUrl.isEmpty) {
      print("الصوت غير متوفر");
      return;
    }

    final fileName = '${surahNumber}_${selectedReciter!.reciterId}.mp3';

    await player.play(UrlSource(audioModel.audioUrl));
    isPlaying = true;
    notifyListeners();

    SurahLogic.getOrDownloadAudio(audioModel.audioUrl, fileName).then((path) {
      print('تم تحميل الملف وتخزينه: $path');
    }).catchError((e) {
      print('فشل تحميل الملف للتخزين المحلي: $e');
    });

    // download
    SurahLogic.fetchAyahs(surahNumber).then((fetchedAyahs) {
      ayahs = fetchedAyahs;
      notifyListeners();
    }).catchError((e) {
      print("فشل تحميل الآيات: $e");
    });

  } catch (e) {
    print("خطأ أثناء تشغيل التلاوة: $e");
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
  // Future<void> playFullSurah(int surahNumber) async {
  //   if (selectedReciter == null) return;

  //   try {
  //     final audioModel = await LogicMethods.fetchSurahAudio(
  //       selectedReciter!.reciterId,
  //       surahNumber,
  //     );

  //     // if (audioModel == null || audioModel.audioUrl.isEmpty) {
  //     //   _showAudioNotFoundMessage();
  //     //   return;
  //     // }

  //     final localPath = await LogicMethods.getOrDownloadAudio(
  //       audioModel!.audioUrl,
  //       '${surahNumber}_${selectedReciter!.reciterId}.mp3',
  //     );

  //     await player.play(DeviceFileSource(localPath));
  //     isPlaying = true;
  //     notifyListeners();
  //   } catch (e) {
  //     print(" خطأ أثناء تشغيل التلاوة: $e");

  //     // _showAudioNotFoundMessage();
  //   }
  // }


  // void _showAudioNotFoundMessage() {
  //   if (_context != null) {
  //     ScaffoldMessenger.of(_context!).showSnackBar(
  //       const SnackBar(
  //         content: Text("  هذه التلاوة غير متوفرة لهذا القارئ."),
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   } else {
  //     print(" التلاوة غير متوفرة،    ");
  //   }
  // }

