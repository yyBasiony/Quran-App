import 'package:hive/hive.dart';

import '../../models/ayah_model.dart';
import '../base_service.dart';

class AyahService extends BaseService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<AyahModel>> fetchSurahAyahs(int surahNumber) async {
    final box = await Hive.openBox('ayahsBox');
    if (box.containsKey(surahNumber)) {
      final cached = box.get(surahNumber);
      if (cached is List) {
        return cached.map((e) => e is AyahModel ? e : AyahModel.fromJson(Map<String, dynamic>.from(e))).toList();
      }
    }

    final data = await getRequest('$baseUrl/surah/$surahNumber/quran-uthmani');
    final ayahs = (data['data']['ayahs'] as List).asMap().entries.map((entry) {
      final index = entry.key;
      final ayah = entry.value;
      return AyahModel(number: index + 1, text: ayah['text']);
    }).toList();

    await box.put(surahNumber, ayahs.map((a) => a.toJson()).toList());
    return ayahs;
  }
}
