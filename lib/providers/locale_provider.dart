import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocaleProvider with ChangeNotifier {
  final String _boxKey = 'localeBox';
  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocaleFromBox();
  }

  void toggleLocale() {
    if (_locale.languageCode == 'ar') {
      _locale = const Locale('en');
    } else {
      _locale = const Locale('ar');
    }
    _saveLocaleToBox(_locale.languageCode);
    notifyListeners();
  }

  void _loadLocaleFromBox() async {
    var box = await Hive.openBox(_boxKey);
    String code = box.get('languageCode', defaultValue: 'ar');
    _locale = Locale(code);
    notifyListeners();
  }

  void _saveLocaleToBox(String languageCode) async {
    var box = await Hive.openBox(_boxKey);
    box.put('languageCode', languageCode);
  }
}
