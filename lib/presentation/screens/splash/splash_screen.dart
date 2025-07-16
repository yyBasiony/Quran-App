import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/extensions/theme_extensions.dart';
import 'package:qanet/presentation/resources/app_assets.dart';
import 'package:qanet/presentation/screens/splash/logic/splash_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      SplashLogic.goNextScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: context.scaffoldColor,
        body: Center(
            child: Image.asset(
          AppAssets.logo,
          width: 220.w,
          height: 220.h,
          fit: BoxFit.contain,
        )));
  }
}
