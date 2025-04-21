import 'package:flutter/material.dart';
import '../../../../models/surah_model.dart';
import '../surah_details_screen.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;
  const SurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF006400),
        child: Text(surah.number.toString(), style: const TextStyle(color: Colors.white)),
      ),
      title: Text(surah.englishName, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(surah.englishName, style: const TextStyle(color: Colors.grey)),
      trailing: Text(surah.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SurahDetailScreen(surahNumber: surah.number, surahName: surah.name)),
        );
      },
    );
  }
}
