import 'package:flutter/material.dart';
import 'package:qanet/extensions/theme_extensions.dart';
import 'package:qanet/providers/surah_detail_provider.dart';

class SurahAyahText extends StatelessWidget {
  final SurahDetailProvider provider;

  const SurahAyahText({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: context.textTheme.displayLarge,
        children: provider.ayahs.map((ayah) {
          return TextSpan(text: '${ayah.text} ﴿${ayah.number}﴾ ');
        }).toList(),
      ),
    );
  }
}
