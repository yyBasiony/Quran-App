import 'package:flutter/material.dart';
import 'package:quran_app/presentation/main/home/main_screen.dart';
import 'package:quran_app/presentation/main/home/prayer_time_page.dart';
import 'package:quran_app/presentation/main/home/surah_details_screen.dart';

class AppRoutes {
  static const String prayerScreen = "/prayerScreen";
  static const String mainScreen = "/main";
  static const String surahDetails = "/surahDetails";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case prayerScreen:
        return MaterialPageRoute(builder: (_) => const PrayerTimesPage());

      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case surahDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final surahNumber = args['surahNumber'] as int;
        final surahName = args['surahName'] as String;

        return MaterialPageRoute(
          builder: (_) => SurahDetailScreen(
            surahNumber: surahNumber,
            surahName: surahName,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}
