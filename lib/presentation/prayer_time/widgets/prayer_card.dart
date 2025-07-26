import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions/theme_extensions.dart';
import '../logic/prayer_times_logic.dart';

class PrayerCard extends StatelessWidget {
  final String name;
  final String time;
  final String imageKey;

  const PrayerCard({
    super.key,
    required this.name,
    required this.time,
    required this.imageKey,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(PrayerTimesLogic.getPrayerImage(imageKey)))),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.55),
                Colors.transparent,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(name, style: textTheme.titleLarge), SizedBox(height: 6.h), Text(time, style: textTheme.titleLarge)],
            ),
          )
        ],
      ),
    );
  }
}
