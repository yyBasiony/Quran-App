import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_preferences.dart';
import '../../../extensions/theme_extensions.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_routes.dart';
import '../welcome_logic.dart';

class StartButton extends StatefulWidget {
  const StartButton({super.key});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  bool isLoading = false;

  Future<void> _handleStart(BuildContext context) async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));
    await AppPreferences.setFirstTime();

    setState(() => isLoading = false);

    StartLogic.handleStartButton(context, () => Navigator.pushReplacementNamed(context, AppRoutes.mainScreen));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return ElevatedButton(
      onPressed: isLoading ? null : () => _handleStart(context),
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r))),
      child: isLoading ? const CircularProgressIndicator(color: Colors.white) : Text("لنبدأ", style: textTheme.bodyMedium),
    );
  }
}
