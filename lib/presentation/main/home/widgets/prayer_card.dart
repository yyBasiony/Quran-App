import 'package:flutter/material.dart';
import 'package:quran_app/presentation/resources/app_assets.dart';

class PrayerCard extends StatelessWidget {
  final String name;
  final String time;
  final Color color;

  const PrayerCard({
    super.key,
    required this.name,
    required this.time,
    required this.color,
  });

  String getPrayerImage(String name) {
    const images = {
      "Fajr": AppAssets.Fajr,
      "Dhuhr": AppAssets.Dhuhr,
      "Asr": AppAssets.Asr,
      "Maghrib": AppAssets.Maghrib,
      "Isha": AppAssets.Isha,
    };
    return images[name] ?? AppAssets.Isha;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final textColor = theme.brightness == Brightness.dark ? Colors.white70 : Colors.white;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: textTheme.titleLarge?.copyWith(color: textColor)),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(time, style: textTheme.bodyLarge?.copyWith(color: textColor)),
              const Spacer(),
              Image.asset(
                getPrayerImage(name),
                width: 40,
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
