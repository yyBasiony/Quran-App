import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanet/providers/theme_provider.dart';
import 'package:qanet/providers/locale_provider.dart';

class SettingLogic {
  static bool isDarkMode(BuildContext context) {
    return context.watch<ThemeProvider>().isDarkMode;
  }

  static bool isArabic(BuildContext context) {
    return context.watch<LocaleProvider>().locale.languageCode == 'ar';
  }

  static void toggleTheme(BuildContext context, bool isOn) {
    context.read<ThemeProvider>().toggleTheme(isOn);
  }

  static void toggleLocale(BuildContext context) {
    context.read<LocaleProvider>().toggleLocale();
  }
}
