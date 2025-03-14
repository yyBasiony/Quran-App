import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/services/audio_service.dart';
import 'package:quran_app/models/audio_mobel.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioService _audioService = AudioService();
  List<AudioModel> reciters = [];
  AudioModel? selectedReciter;
  int? selectedSurahNumber;

  @override
  void initState() {
    super.initState();
    fetchReciters();
  }

  Future<void> fetchReciters() async {
    try {
      List<AudioModel> fetchedReciters = await _audioService.fetchReciters();
      setState(() => reciters = fetchedReciters);
    } catch (e) {
      print('Error loading reciters: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<AudioModel>(
              value: selectedReciter,
              hint: const Text('Select Reciter'),
              items: reciters.map((reciter) {
                return DropdownMenuItem<AudioModel>(
                  value: reciter,
                  child: Text(reciter.reciterName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedReciter = value;
                  selectedSurahNumber = null;
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedReciter != null)
              DropdownButton<int>(
                value: selectedSurahNumber,
                hint: const Text('Select Surah'),
                items: List.generate(114, (index) {
                  int surahNumber = index + 1;
                  return DropdownMenuItem<int>(
                    value: surahNumber,
                    child: Text('Surah $surahNumber'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    selectedSurahNumber = value;
                  });
                },
              ),
            const SizedBox(height: 16),
            if (selectedReciter != null && selectedSurahNumber != null)
              AudioPlayerWidget(
                reciterId: selectedReciter!.reciterId,
                surahNumber: selectedSurahNumber!,
              ),
          ],
        ),
      ),
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  final int reciterId;
  final int surahNumber;

  const AudioPlayerWidget({super.key, required this.reciterId, required this.surahNumber});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioService _audioService = AudioService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isLoading = false;
  bool isPlaying = false;

  Future<void> playAudio() async {
    setState(() => isLoading = true);

    try {
      AudioModel? audio = await _audioService.fetchSurahAudio(widget.reciterId, widget.surahNumber);
      if (audio == null) {
        throw Exception('No audio available');
      }

      String filename = '${widget.reciterId}_${widget.surahNumber}.mp3';
      if (audio.moshafs.isEmpty) {
        throw Exception('No audio available');
      }

      String audioUrl = audio.moshafs.first.audioUrl;
      String filePath = await _audioService.getOrDownloadAudio(audioUrl, filename);

      await _audioPlayer.play(DeviceFileSource(filePath));
      setState(() => isPlaying = true);
      print('Playing audio: $filePath');
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    setState(() => isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: isLoading
              ? null
              : isPlaying
                  ? stopAudio
                  : playAudio,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Icon(
                  isPlaying ? Icons.stop : Icons.mic,
                  color: Colors.black,
                  size: 40,
                ),
        ),
        const SizedBox(height: 10),
        Text(
          isPlaying ? 'Playing' : 'Tap to play',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
