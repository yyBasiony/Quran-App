import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/presentation/resources/app_colors.dart';
import 'package:qanet/presentation/routes/app_routes.dart';
import '../../../../data/models/surah_model.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;

  const SurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final avatarTextColor = theme.brightness == Brightness.dark ? Colors.white70 : Colors.white;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.primary,
          child: Text(surah.number.toString(), style: TextStyle(color: avatarTextColor, fontSize: 14.sp, fontWeight: FontWeight.bold))),
      title: Text(surah.englishName, style: textTheme.headlineMedium),
      trailing: Text(surah.name, style: textTheme.headlineMedium),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.surahDetails, arguments: {'surahNumber': surah.number, 'surahName': surah.name});
      },
    );
  }
}
