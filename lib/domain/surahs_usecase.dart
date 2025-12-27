import '../../data/models/surah_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/services/base_service.dart';
import '../data/services/exceptions.dart';
import '../data/services/quran/i_surah_service.dart';

class SurahsUseCase extends BaseService {
  final ISurahService _ayahService;

  SurahsUseCase(this._ayahService);

  Future<List<SurahModel>> execute() async {
    final box = await Hive.openBox<SurahModel>('surahsBox');
    List<SurahModel> cachedSurahs = [];

    if (box.isNotEmpty) {
      cachedSurahs = box.values.toList();
    }

    try {
      await checkInternetOrThrow(); 
      final updatedSurahs = await _ayahService.fetchSurahs();
      return updatedSurahs;
    } on AppException {
      if (cachedSurahs.isNotEmpty) return cachedSurahs;
      rethrow; 
    } catch (_) {
      if (cachedSurahs.isNotEmpty) return cachedSurahs;
      throw UnknownException(); 
    }
  }
}
