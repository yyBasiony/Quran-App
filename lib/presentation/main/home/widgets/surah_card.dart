import 'package:flutter/material.dart';
import '../../../../models/surah_model.dart';
import '../surah_details_screen.dart';
import '../../../resources/app_colors.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;

  const SurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Text(
          surah.number.toString(),
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      title: Text(
        surah.englishName,
        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        surah.name,
        style: textTheme.titleLarge?.copyWith(fontSize: 18),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SurahDetailScreen(
              surahNumber: surah.number,
              surahName: surah.name,
            ),
          ),
        );
      },
    );
  }
}
