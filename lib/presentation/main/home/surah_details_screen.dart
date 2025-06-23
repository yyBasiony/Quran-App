import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/models/audio_mobel.dart';
import 'package:quran_app/presentation/resources/app_colors.dart';
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
  Future.delayed(Duration.zero, () {
    provider.setContext(context); 
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          widget.surahName,
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      body: Consumer<SurahDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.orange, width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.surahName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange,
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
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Uthmani',
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      children: provider.ayahs.map((ayah) {
                        return TextSpan(text: '${ayah.text} ﴿${ayah.number}﴾ ');
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<SurahDetailProvider>(
        builder: (context, provider, child) {
          return BottomAppBar(
            elevation: 10,
            color: theme.cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      provider.isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: theme.primaryColor,
                      size: 30,
                    ),
                    onPressed: provider.isPlaying
                        ? provider.pauseAudio
                        : () => provider.playFullSurah(widget.surahNumber),
                  ),
                  DropdownButton<AudioModel>(
                    value: provider.selectedReciter,
                    underline: const SizedBox(),
                    icon: Icon(Icons.keyboard_arrow_down, color: theme.primaryColor),
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
