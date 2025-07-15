import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qanet/presentation/routes/app_routes.dart';
import 'package:qanet/presentation/resources/app_theme.dart';
import 'package:qanet/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AppWrappers extends StatelessWidget {
  const AppWrappers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              onGenerateRoute: AppRoutes.generateRoutes,
              initialRoute: AppRoutes.splashScreen,
            );
          },
        );
      },
    );
  }
}
