import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quran_app/app/app.dart';

import 'models/ayah_model.dart';
import 'models/surah_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SurahModelAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(AyahModelAdapter());
  }

  runApp(const IslamicApp());
}
