import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/prayer_times_provider.dart';
import '../../resources/app_constants.dart';
import 'widgets/city_dropdown.dart';
import 'widgets/prayer_card.dart';

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrayerTimesProvider>(context);
    final prayerTimes = provider.prayerTimes;

    Map<String, String> prayers = {
      "Fajr": prayerTimes?.fajr ?? "--:--",
      "Dhuhr": prayerTimes?.dhuhr ?? "--:--",
      "Asr": prayerTimes?.asr ?? "--:--",
      "Maghrib": prayerTimes?.maghrib ?? "--:--",
      "Isha": prayerTimes?.isha ?? "--:--",
    };

    prayers.remove(provider.nextPrayer);

    List<Color> colors = [
      const Color(0xff9ACD32),
      const Color(0xff714ae5),
      const Color(0xffeba065),
      const Color(0xff00c27e),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD6EFE7),
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
                color: const Color(0xFF006400),
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.nextPrayer,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    provider.nextPrayerTime,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Prayer Times", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
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
