import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/presentation/main/home/main_screen.dart';
import 'package:quran_app/presentation/main/home/surah_details_screen.dart';
import '../../../providers/main_provider.dart';
import '../../../providers/surah_detail_provider.dart';

class AppRoutes {
  static const String mainScreen = "/main";
  static const String surahDetails = "/surahDetails";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {

      case mainScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => MainProvider(),
            child: const MainScreen(),
          ),
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

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}
