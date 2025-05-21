import 'package:flutter/material.dart';
import '../../../../models/surah_model.dart';
import '../surah_details_screen.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;

  const SurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final avatarBgColor = theme.brightness == Brightness.dark
        ? Colors.green.shade700  
        : theme.colorScheme.primary; 

    final avatarTextColor = theme.brightness == Brightness.dark
        ? Colors.white70
        : Colors.white;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: avatarBgColor,
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
