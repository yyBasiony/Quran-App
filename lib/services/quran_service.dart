import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran_app/models/search_ayah_model.dart';
import '../models/surah_model.dart';
import '../models/ayah_model.dart';

class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<SurahModel>> fetchSurahs() async {
    final url = Uri.parse('$baseUrl/surah');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> surahsData = jsonData['data'];

        return surahsData.map((json) => SurahModel.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception: $e');
    }
  }

  Future<List<AyahModel>> fetchSurahAyahs(int surahNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/surah/$surahNumber/quran-uthmani'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('data') && responseData['data'].containsKey('ayahs')) {
        final List<dynamic> ayahsData = responseData['data']['ayahs'];
        return ayahsData.map((json) => AyahModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Ayahs');
      }
    } else {
      throw Exception('Failed to load Ayahs: ${response.statusCode}');
    }
  }

  Future<List<SearchAyahModel>> searchAyah(String searchText) async {
    final response = await http.get(Uri.parse('https://api-quran.com/api?text=$searchText&type=search'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('result') && data['result'] is List) {
        final List<dynamic> results = data['result'];
        return results.map((ayahText) => SearchAyahModel.fromText(ayahText)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to search Ayah: ${response.statusCode}');
    }
  }
}
