import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/presentation/resources/app_routes.dart';
import 'package:quran_app/presentation/resources/app_theme.dart';
import 'package:quran_app/presentation/start_screen.dart';
import 'package:quran_app/providers/theme_provider.dart';
import 'package:quran_app/presentation/main/home/main_screen.dart';

class IslamicApp extends StatelessWidget {
  final bool isFirstTime;
  const IslamicApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          onGenerateRoute: AppRoutes.generateRoutes,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: isFirstTime ? const StartScreen() : const MainScreen(),
        );
      },
    );
  }
}
