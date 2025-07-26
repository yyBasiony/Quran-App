import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  bool get isArabic => locale.languageCode == 'ar';

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get primaryColor => Theme.of(this).primaryColor;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
