import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/audio_mobel.dart';
import 'package:quran_app/providers/surah_detail_provider.dart';

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
  late SurahDetailProvider provider;

  @override
  void initState() {
    super.initState();
    // تأجيل تحميل البيانات بعد build
    Future.delayed(Duration.zero, () {
      provider.loadData(widget.surahNumber);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<SurahDetailProvider>(context, listen: false);
  }

  @override
  void dispose() {
    provider.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SurahDetailProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFD6EFE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006400),
        title: Text(
          widget.surahName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  provider.isPlaying ? Icons.pause_circle : Icons.play_circle,
                  color: const Color(0xFF006400),
                  size: 30,
                ),
                onPressed: provider.isPlaying
                    ? provider.pauseAudio
                    : () => provider.playFullSurah(widget.surahNumber),
              ),
              DropdownButton<AudioModel>(
                value: provider.selectedReciter,
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF006400)),
                onChanged: (value) {
                  if (value != null) {
                    provider.changeReciter(value);
                  }
                },
                items: provider.reciters.map((reciter) {
                  return DropdownMenuItem(
                    value: reciter,
                    child: Text(
                      reciter.reciterName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006400),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    widget.surahName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontFamily: 'Uthmani',
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: RichText(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Uthmani',
                          color: Colors.black,
                        ),
                        children: provider.ayahs.map((ayah) {
                          return TextSpan(text: '${ayah.text} ﴿${ayah.number}﴾ ');
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
