import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/presentation/main/home/widgets/surah_card.dart';
import 'package:quran_app/providers/surah_provider.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6EFE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006400),
        title: const Text('Al-Quran', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<SurahProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن سورة...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: provider.filterSurahs,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.surahs.length,
                  itemBuilder: (context, index) {
                    final surah = provider.surahs[index];
                    return SurahCard(surah: surah);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
