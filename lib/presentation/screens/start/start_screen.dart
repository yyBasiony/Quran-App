import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qanet/presentation/resources/app_assets.dart';
import 'package:qanet/presentation/resources/app_colors.dart';
import 'package:qanet/presentation/screens/start/widgets/start_button.dart';

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
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                            style: textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            '﴿ وَقُومُوا لِلَّهِ قَانِتِينَ﴾',
                            style: textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4.h)
                        ])),
                    SizedBox(height: 36.h),
                    const StartButton(),
                  ])))
        ]));
  }
}
