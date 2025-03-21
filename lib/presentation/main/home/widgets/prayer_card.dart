import 'package:flutter/material.dart';

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
  String getPrayerImage(String prayerName) {
    Map<String, String> prayerImages = {
      "Fajr": 'assets/Fajr.png',
      "Dhuhr": 'assets/Dhuhr.png',
      "Asr": 'assets/Asr.png',
      "Maghrib": 'assets/Maghrib.png',
      "Isha": 'assets/Isha.png',
    };

    return prayerImages[prayerName] ?? 'assets/images/Isha.png';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 40),
              Image.asset(
                getPrayerImage(name),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
