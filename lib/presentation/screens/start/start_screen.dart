import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/core/themes/app_assets.dart';
import 'package:qanet/core/themes/app_colors.dart';
import 'package:qanet/presentation/routes/app_routes.dart';
import '../../../../providers/start_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(children: [
        SizedBox.expand(child: Image.asset(AppAssets.welcome, fit: BoxFit.cover, colorBlendMode: BlendMode.darken)),
        Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(height: 90.h),
                Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(16.r), boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ]),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Uthmani',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '﴾وَقُومُوا لِلَّهِ قَانِتِينَ﴿',
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 26.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Uthmani',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                    ])),
                SizedBox(height: 36.h),
                Consumer<StartProvider>(builder: (context, startProvider, _) {
                  return ElevatedButton(
                      onPressed: startProvider.isLoading
                          ? null
                          : () async {
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('is_first_time', false);

                              startProvider.startApp(context, () => Navigator.pushReplacementNamed(context, AppRoutes.mainScreen));
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r))),
                      child: startProvider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("لنبدأ",
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              )));
                })
              ])),
        )
      ]),
    );
  }
}
