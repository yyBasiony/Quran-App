import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get scaffoldColor => Theme.of(this).scaffoldBackgroundColor;

  Color get primaryColor => Theme.of(this).primaryColor;
}
