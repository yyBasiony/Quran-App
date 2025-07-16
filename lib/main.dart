import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qanet/app/app_preferences.dart';
import 'data/models/ayah_model.dart';
import 'data/models/surah_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qanet/app/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await AppPreferences.init();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SurahModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(AyahModelAdapter());
  }

 runApp(const AppLocalization());}
