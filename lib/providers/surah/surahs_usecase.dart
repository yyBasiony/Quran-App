import '../../../data/models/surah_model.dart';
import '../../../data/services/quran/surah_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/connectivity_helper.dart';

class SurahsUseCase {
  final SurahService _ayahService;

  SurahsUseCase(this._ayahService);

  Future<List<SurahModel>> execute() async {
    final box = await Hive.openBox<SurahModel>('surahsBox');
    List<SurahModel> cachedSurahs = [];

    if (box.isNotEmpty) {
      cachedSurahs = box.values.toList();
    }

    final hasInternet = await ConnectivityHelper.hasInternet();
    if (hasInternet) {
      final updatedSurahs = await _ayahService.fetchSurahs();
      return updatedSurahs;
    } else {
      if (cachedSurahs.isEmpty) throw Exception("noInternetMessage");
      return cachedSurahs;
    }
  }
}
