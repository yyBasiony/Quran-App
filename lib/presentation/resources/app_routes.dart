import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanet/presentation/screens/home/main_screen.dart';
import 'package:qanet/presentation/screens/splash/splash_screen.dart';
import 'package:qanet/presentation/screens/surah/surah_details_screen.dart';
import 'package:qanet/presentation/screens/start/start_screen.dart';
import '../../../providers/surah_detail_provider.dart';

class AppRoutes {
    static const String splashScreen = "/";
  static const String mainScreen = "/main";
  static const String surahDetails = "/surahDetails";
    static const String startScreen = "/startScreen";


  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
case splashScreen:
  return MaterialPageRoute(
    builder: (_) => const SplashScreen(),
  );

case mainScreen:
  return MaterialPageRoute(
    builder: (_) => const MainScreen(),
  );

case surahDetails:
  final args = settings.arguments as Map<String, dynamic>;
  final surahNumber = args['surahNumber'] as int;
  final surahName = args['surahName'] as String;

  return MaterialPageRoute(
    builder: (_) => ChangeNotifierProvider(
      create: (_) => SurahDetailProvider(),
      child: SurahDetailScreen(
        surahNumber: surahNumber,
        surahName: surahName,
      ),
    ),
  );
      case startScreen:
        return MaterialPageRoute(
          builder: (_) => const StartScreen(),
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
