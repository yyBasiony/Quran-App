import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:qanet/providers/theme_provider.dart';

class SettingLogic {
  static bool isDarkMode(BuildContext context) {
    return context.watch<ThemeProvider>().isDarkMode;
  }

  static bool isArabic(BuildContext context) {
    return context.locale.languageCode == 'ar';
  }

  static void toggleTheme(BuildContext context, bool isOn) {
    context.read<ThemeProvider>().toggleTheme(isOn);
  }

  static void toggleLocale(BuildContext context) {
    final currentLocale = context.locale;
    final newLocale = currentLocale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');
    context.setLocale(newLocale);
  }
}
