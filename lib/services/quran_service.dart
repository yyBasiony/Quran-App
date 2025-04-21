import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/models/search_ayah_model.dart';
import '../models/surah_model.dart';
import '../models/ayah_model.dart';

class QuranService {

  static const String baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<SurahModel>> fetchSurahs() async {
    final box = await Hive.openBox<SurahModel>('surahsBox');

    if (box.isNotEmpty) {
       print(" الداتا من التخزين المحلي");
      return box.values.toList();
    } else {
      print("  الداتا من ال api");
      final url = Uri.parse('$baseUrl/surah');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final List<dynamic> surahsData = jsonData['data'];
          final List<SurahModel> surahList = surahsData.map((json) => SurahModel.fromJson(json)).toList();

          for (var surah in surahList) {
            box.put(surah.number, surah);
          }

          return surahList;
        } else {
          throw Exception('Error: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Exception: $e');
      }
    }
  }

Future<List<AyahModel>> fetchSurahAyahs(int surahNumber) async {
  final box = await Hive.openBox('ayahsBox'); 

  if (box.containsKey(surahNumber)) {
    print("    التخزين المحلي لـ سورة رقم: $surahNumber");

    final dynamic cachedData = box.get(surahNumber);

    if (cachedData is List<dynamic>) {
      return cachedData.map((e) {
        if (e is Map) {
          return AyahModel.fromJson(Map<String, dynamic>.from(e));
        } else if (e is AyahModel) {
          return e; 
        } else {
          throw Exception("حدث خطأ في قراءة بيانات Hive");
        }
      }).toList();
    } else {
      return [];
    }
  }

  print("  الداتا من ال API");
  final url = Uri.parse('$baseUrl/surah/$surahNumber/quran-uthmani');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('data') && responseData['data'].containsKey('ayahs')) {
        final List<dynamic> ayahsData = responseData['data']['ayahs'];
        final List<AyahModel> ayahsList = ayahsData.map((json) => AyahModel.fromJson(json)).toList();

        await box.put(surahNumber, ayahsList.map((ayah) => ayah.toJson()).toList());

        return ayahsList;
      } else {
        throw Exception('لا توجد بيانات للعرض');
      }
    } else {
      throw Exception('فشل في تحميل البيانات (رمز الخطأ: ${response.statusCode})');
    }
  } catch (e) {
    print('خطأ: $e');
    throw Exception('حدث خطأ أثناء جلب البيانات، برجاء المحاولة لاحقًا');
  }
}
Future<List<SearchAyahModel>> searchAyah(String searchText) async {
  final response = await http.get(Uri.parse('https://api-quran.com/api?text=$searchText&type=search'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data.containsKey('result') && data['result'] is List) {
      final List<dynamic> results = data['result'];
      return results
          .whereType<String>()
          .map((ayahText) => SearchAyahModel(text: ayahText))
          .toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to search Ayah: ${response.statusCode}');
  }
}
}

