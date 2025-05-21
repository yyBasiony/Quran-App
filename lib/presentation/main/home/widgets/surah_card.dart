import 'package:flutter/material.dart';
import 'package:quran_app/presentation/resources/app_colors.dart';
import 'package:quran_app/presentation/resources/app_routes.dart';
import '../../../../models/surah_model.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;

  const SurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final avatarTextColor = theme.brightness == Brightness.dark ? Colors.white70 : Colors.white;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Text(
          surah.number.toString(),
          style: TextStyle(color: avatarTextColor),
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
        Navigator.pushNamed(
          context,
          AppRoutes.surahDetails,
          arguments: {
            'surahNumber': surah.number,
            'surahName': surah.name,
          },
        );
      },
    );
  }
}
