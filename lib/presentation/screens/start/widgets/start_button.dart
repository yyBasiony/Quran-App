import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/core/themes/app_colors.dart';
import 'package:qanet/core/utils/start_logic.dart';
import 'package:qanet/presentation/routes/app_routes.dart';
import '../../../../providers/start_provider.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<StartProvider>(
      builder: (context, startProvider, _) {
        return ElevatedButton(
            onPressed: startProvider.isLoading
                ? null
                : () {
                    startProvider.startApp(context, () {
                      StartLogic.handleStartButton(
                        context,
                        () => Navigator.pushReplacementNamed(context, AppRoutes.mainScreen),
                      );
                    });
                  },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                )),
            child: startProvider.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text("لنبدأ",
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    )));
      },
    );
  }
}
