import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/core/themes/app_assets.dart';

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

  String getPrayerImage(String key) {
    const images = {
      "Fajr": AppAssets.Fajr,
      "Dhuhr": AppAssets.Dhuhr,
      "Asr": AppAssets.Asr,
      "Maghrib": AppAssets.Maghrib,
      "Isha": AppAssets.Isha,
    };
    return images[key] ?? AppAssets.Isha;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            image: AssetImage(getPrayerImage(imageKey)),
            fit: BoxFit.cover,
          )),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.transparent,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.sp)),
                SizedBox(height: 6.h),
                Text(
                  time,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                    fontSize: 18.sp, 
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
