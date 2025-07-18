import 'package:hive/hive.dart';
import '../models/search_ayah_model.dart';
import '../models/surah_model.dart';
import '../models/ayah_model.dart';
import 'base_service.dart';

class QuranService extends BaseService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<SurahModel>> fetchSurahs() async {
    final box = await Hive.openBox<SurahModel>('surahsBox');

    if (box.isNotEmpty) {
      print("من التخزين المحلي");
      return box.values.toList();
    }

    final data = await getRequest('$baseUrl/surah');
    final List<dynamic> surahsData = data['data'];
    final surahList = surahsData.map((json) => SurahModel.fromJson(json)).toList();

    for (var surah in surahList) {
      box.put(surah.number, surah);
    }

    return surahList;
  }

  Future<List<AyahModel>> fetchSurahAyahs(int surahNumber) async {
    final box = await Hive.openBox('ayahsBox');

    if (box.containsKey(surahNumber)) {
      print("من التخزين المحلي لـ سورة $surahNumber");
      final cachedData = box.get(surahNumber);
      if (cachedData is List) {
        return cachedData.map((e) => e is AyahModel ? e : AyahModel.fromJson(Map<String, dynamic>.from(e))).toList();
      } else {
        return [];
      }
    }

    print("من الـ API");
    final url = '$baseUrl/surah/$surahNumber/quran-uthmani';
    final data = await getRequest(url);

    final List<dynamic> ayahsData = data['data']['ayahs'];
    final ayahList = ayahsData.asMap().entries.map((entry) {
      final index = entry.key;
      final ayahJson = entry.value;
      return AyahModel(number: index + 1, text: ayahJson['text']);
    }).toList();

    await box.put(surahNumber, ayahList.map((a) => a.toJson()).toList());
    return ayahList;
  }

  Future<List<SearchAyahModel>> searchAyah(String searchText) async {
    final data = await getRequest('https://api-quran.com/api?text=$searchText&type=search');

    if (data.containsKey('result') && data['result'] is List) {
      return (data['result'] as List)
          .whereType<String>()
          .map((text) => SearchAyahModel(text: text))
          .toList();
    }

    return [];
  }
}
