import 'package:flutter/material.dart';
import 'package:qanet/data/models/ayah_model.dart';
import 'package:qanet/data/models/audio_mobel.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:qanet/presentation/screens/surah/logic/surah_logic.dart';

class SurahDetailProvider with ChangeNotifier {
  List<AyahModel> ayahs = [];
  List<AudioModel> reciters = [];
  bool isLoading = true;
  bool hasFailedToLoad = false;
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
    this.context = context;
  }

  Future<void> loadData(int surahNumber) async {
    isLoading = true;
    hasFailedToLoad = false;
    notifyListeners();
    
    try {
      ayahs = await SurahLogic.fetchAyahs(surahNumber, context: context);
      reciters = await SurahLogic.fetchRecitersWithSurah(surahNumber, context: context);
      
      if (reciters.isNotEmpty) {
        selectedReciter = reciters.first;
      } else {
        selectedReciter = null;
      }
      
      hasFailedToLoad = false;
    } catch (e) {
      hasFailedToLoad = true; 
    }
    
    isLoading = false;
    notifyListeners();
  }

  Future<void> retryLoading() async {
    if (context != null) {
    }
  }

  Future<void> playFullSurah(int surahNumber) async {
    if (selectedReciter == null) return;
    
    try {
      final audioModel = await SurahLogic.fetchSurahAudio(
        selectedReciter!.reciterId,
        surahNumber,
        context: context,
      );
      
      if (audioModel == null || audioModel.audioUrl.isEmpty) {
        //print("الصوت غير متوفر");
        return;
      }

      final fileName = '${surahNumber}_${selectedReciter!.reciterId}.mp3';
      await player.play(UrlSource(audioModel.audioUrl));
      isPlaying = true;
      notifyListeners();

      SurahLogic.getOrDownloadAudio(audioModel.audioUrl, fileName, context: context).then((path) {
       // print('تم تحميل الملف وتخزينه: $path');
      }).catchError((e) {
       // print('فشل تحميل الملف للتخزين المحلي: $e');
      });

    } catch (e) {
     // print("خطأ أثناء تشغيل التلاوة: $e");
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
