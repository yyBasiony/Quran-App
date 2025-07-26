import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_preferences.dart';
import '../resources/app_assets.dart';
import '../resources/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  late bool _isFirstTime;

  @override
  void dispose() => {_timer.cancel(), super.dispose()};

  void _startTimer() => _timer = Timer(const Duration(seconds: 3), () => _goNextScreen());

  @override
  void initState() => {super.initState(), _startTimer(), _isFirstTime = AppPreferences.isFirstTime()};

  void _goNextScreen() => Navigator.pushReplacementNamed(context, _isFirstTime ? AppRoutes.welcomeScreen : AppRoutes.mainScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppAssets.logo, width: 220.w, height: 220.h, fit: BoxFit.contain)),
    );
  }
}
