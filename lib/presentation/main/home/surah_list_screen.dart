import 'package:flutter/material.dart';
import 'package:quran_app/models/surah_model.dart';
import 'package:quran_app/presentation/main/home/widgets/surah_card.dart';
import 'package:quran_app/services/quran_service.dart';
//import 'package:quran_app/presentation/main/home/widgets/ayah_search_bar.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({Key? key}) : super(key: key);

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  List<SurahModel> surahs = [];
  List<SurahModel> filteredSurahs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final quranService = QuranService();
    final data = await quranService.fetchSurahs();
    setState(() {
      surahs = data;
      filteredSurahs = data;
      isLoading = false;
    });
  }

  void filterSurahs(String query) {
    final filtered = surahs.where((surah) => surah.englishName.toLowerCase().contains(query.toLowerCase()) || surah.name.contains(query)).toList();
    setState(() {
      filteredSurahs = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6EFE7),
      appBar: AppBar(backgroundColor: Color(0xFF006400), title: const Text('Al-Quran')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                //const AyahSearchBar(),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredSurahs.length,
                    itemBuilder: (context, index) {
                      final surah = filteredSurahs[index];
                      return SurahCard(surah: surah);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
