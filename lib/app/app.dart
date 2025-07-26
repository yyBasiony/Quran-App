import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../presentation/resources/app_routes.dart';
import '../presentation/resources/app_theme.dart';
import '../providers/theme_provider.dart';

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          designSize: const Size(390, 844),
          builder: (context, _) {
            return MaterialApp(
              locale: context.locale,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutes.splashScreen,
              themeMode: themeProvider.currentThemeMode,
              onGenerateRoute: AppRoutes.generateRoutes,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
            );
          },
        );
      },
    );
  }
}
