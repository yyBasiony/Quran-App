import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/providers/surah_detail_provider.dart';

class SurahAyahText extends StatelessWidget {
  final SurahDetailProvider provider;

  const SurahAyahText({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: TextStyle(
          fontSize: 26.sp,
          fontFamily: 'Uthmani',
          color: theme.textTheme.bodyLarge?.color,
        ),
        children: provider.ayahs.map((ayah) {
          return TextSpan(text: '${ayah.text} ﴿${ayah.number}﴾ ');
        }).toList(),
      ),
    );
  }
}
