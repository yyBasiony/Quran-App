import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/presentation/resources/app_assets.dart';
import '../../../providers/prayer_times_provider.dart';
import '../../resources/app_constants.dart';
import '../../resources/app_colors.dart';
import 'widgets/city_dropdown.dart';
import 'widgets/prayer_card.dart';

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrayerTimesProvider>(context);
    final prayerTimes = provider.prayerTimes;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    Map<String, String> prayers = {
      "Fajr": prayerTimes?.fajr ?? "--:--",
      "Dhuhr": prayerTimes?.dhuhr ?? "--:--",
      "Asr": prayerTimes?.asr ?? "--:--",
      "Maghrib": prayerTimes?.maghrib ?? "--:--",
      "Isha": prayerTimes?.isha ?? "--:--",
    };

    prayers.remove(provider.nextPrayer);

    List<Color> colors = [
      AppColors.prayerCard1,
      AppColors.prayerCard2,
      AppColors.prayerCard3,
      AppColors.prayerCard4,
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            CityDropdown(
              selectedCity: provider.selectedCity,
              cities: AppConstants.cities,
              onCityChanged: provider.changeCity,
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(AppAssets.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.nextPrayer,
                    style: textTheme.titleLarge?.copyWith(color: AppColors.onPrimary),
                  ),
                  Text(
                    provider.nextPrayerTime,
                    style: textTheme.titleLarge?.copyWith(
                      fontSize: 30,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Prayer Times",
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: prayers.entries.map((entry) {
                  int index = prayers.keys.toList().indexOf(entry.key);
                  return PrayerCard(
                    name: entry.key,
                    time: entry.value,
                    color: colors[index % colors.length],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
