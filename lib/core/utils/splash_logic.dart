import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qanet/presentation/routes/app_routes.dart';

class SplashLogic {
  static Future<void> goNextScreen(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('is_first_time') ?? true;

    final nextRoute =
        isFirstTime ? AppRoutes.startScreen : AppRoutes.mainScreen;

    Navigator.pushReplacementNamed(context, nextRoute);
  }
}
