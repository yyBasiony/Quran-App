import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app/app_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('ar');

  Locale get currentLocale => _currentLocale;

  LocaleProvider() {
    _loadLocaleFromPrefs();
  }

  Future<void> toggleLocale(BuildContext context) async {
    _currentLocale = _currentLocale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    AppPreferences.setLanguageCode(_currentLocale.languageCode);
    await context.setLocale(_currentLocale);
    notifyListeners();
  }

  void _loadLocaleFromPrefs() async {
    final langCode = await AppPreferences.getLanguageCode();
    _currentLocale = Locale(langCode);
    notifyListeners();
  }

  bool isArabic() => _currentLocale.languageCode == 'ar';
}
