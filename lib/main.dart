import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:qanet/providers/main_provider.dart';
import 'package:qanet/providers/locale_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'package:qanet/app/app.dart';
import 'data/models/ayah_model.dart';
import 'data/models/surah_model.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SurahModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(AyahModelAdapter());
  }

  //final prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => MainProvider()), 
      ChangeNotifierProvider(create: (_) => LocaleProvider()),


    ],
    child: IslamicApp(),
  ));
}
