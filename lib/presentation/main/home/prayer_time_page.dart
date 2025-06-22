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

    Map<String, String> arabicNames = {
      "Fajr": "الفجر",
      "Dhuhr": "الظهر",
      "Asr": "العصر",
      "Maghrib": "المغرب",
      "Isha": "العشاء",
    };

    Map<String, String> prayers = {
      "Fajr": prayerTimes?.fajr ?? "--:--",
      "Dhuhr": prayerTimes?.dhuhr ?? "--:--",
      "Asr": prayerTimes?.asr ?? "--:--",
      "Maghrib": prayerTimes?.maghrib ?? "--:--",
      "Isha": prayerTimes?.isha ?? "--:--",
    };

    prayers.remove(provider.nextPrayer);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        centerTitle: true,
        title: CityDropdown(
          selectedCity: provider.selectedCity,
          cities: AppConstants.cities,
          onCityChanged: provider.changeCity,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(getPrayerImage(provider.nextPrayer)),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                ),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(arabicNames[provider.nextPrayer] ?? provider.nextPrayer, style: textTheme.titleLarge?.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Text(provider.nextPrayerTime, style: textTheme.titleLarge?.copyWith(fontSize: 30, color: Colors.white))
              ]),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text("مواقيت الصلاة",
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold, color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary))),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: prayers.entries.map((entry) {
                  String englishKey = entry.key;
                  String arabicName = arabicNames[englishKey] ?? englishKey;

                  return PrayerCard(
                    name: arabicName,
                    time: entry.value,
                    imageKey: englishKey,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
