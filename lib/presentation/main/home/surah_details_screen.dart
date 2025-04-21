import 'package:flutter/material.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/models/audio_mobel.dart';
import 'package:audioplayers/audioplayers.dart';

import 'widgets/logic_methods.dart';

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const SurahDetailScreen({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  List<AyahModel> ayahs = [];
  List<AudioModel> reciters = [];
  bool isLoading = true;
  final player = AudioPlayer();
  AudioModel? selectedReciter;
  bool isPlaying = false;
  Future<void> loadData() async {
    final ayahList = await LogicMethods.fetchAyahs(widget.surahNumber);
    final recitersList = await LogicMethods.fetchReciters();

    setState(() {
      ayahs = ayahList;
      reciters = recitersList;
      selectedReciter = recitersList.first;
      isLoading = false;
    });
  }

  Future<void> playFullSurah() async {
    if (selectedReciter == null) return;

    final audioModel = await LogicMethods.fetchSurahAudio(
      selectedReciter!.reciterId,
      widget.surahNumber,
    );

    if (audioModel != null && audioModel.audioUrl.isNotEmpty) {
      final localPath = await LogicMethods.getOrDownloadAudio(
        audioModel.audioUrl,
        '${widget.surahNumber}_${selectedReciter!.reciterId}.mp3',
      );
      await player.play(DeviceFileSource(localPath));
      setState(() => isPlaying = true);
    }
  }

  void pauseAudio() async {
    await player.pause();
    setState(() => isPlaying = false);
  }

  @override
  void initState() {
    super.initState();
    loadData();

    player.onPlayerComplete.listen((event) {
      setState(() => isPlaying = false);
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color(0xFFD6EFE7), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF006400),
        title: Text(widget.surahName),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color:  Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  color: const Color(0xFF006400),
                  size: 30,
                ),
                onPressed: isPlaying ? pauseAudio : playFullSurah,
              ),
              DropdownButton<AudioModel>(
                value: selectedReciter,
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF006400)),
                onChanged: (value) => setState(() => selectedReciter = value),
                items: reciters.map((reciter) {
                  return DropdownMenuItem(
                    value: reciter,
                    child: Text(reciter.reciterName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006400),
                        )),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 1.5), borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    widget.surahName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange, fontFamily: 'Uthmani'),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: RichText(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: const TextStyle(fontSize: 24, fontFamily: 'Uthmani', color: Colors.black),
                        children: ayahs.map((ayah) {
                          return TextSpan(
                            text: '${ayah.text} ﴿${ayah.number}﴾ ',
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
