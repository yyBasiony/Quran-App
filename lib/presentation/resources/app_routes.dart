import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/surah_detail_provider.dart';
import '../main/main_screen.dart';
import '../splash/splash_screen.dart';
import '../surah/surah_details_screen.dart';
import '../welcome/welcome_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splashScreen = "/splash";
  static const String welcomeScreen = "/welcome";

  //
  static const String mainScreen = "/main";
  static const String surahDetailsScreen = "/surah-details";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case surahDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final surahName = args['surahName'] as String;
        final surahNumber = args['surahNumber'] as int;

        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SurahDetailProvider(),
            child: SurahDetailScreen(surahName: surahName, surahNumber: surahNumber),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text("No Route Found"))));
    }
  }
}
