import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/audio_mobel.dart';

class AudioService {
  static const String baseUrl = 'https://mp3quran.net/api/v3';

  Future<List<AudioModel>> fetchReciters() async {
    final response = await http.get(Uri.parse('$baseUrl/reciters'));

    if (response.statusCode == 200) {
      final List<dynamic> recitersJson = jsonDecode(response.body)['reciters'];

      return recitersJson.map((reciter) => AudioModel.fromJson(reciter, 1)).toList();
    } else {
      throw Exception('   فشل تحميل القراء');
    }
  }

 Future<List<AudioModel>> fetchRecitersWithSurah(int surahNumber) async {
  final response = await http.get(Uri.parse('https://mp3quran.net/api/v3/reciters'));

  if (response.statusCode == 200) {
    final List<dynamic> recitersJson = jsonDecode(response.body)['reciters'];

    final filtered = recitersJson.where((reciter) {
      final moshafList = reciter['moshaf'] as List<dynamic>?;

      if (moshafList == null || moshafList.isEmpty) return false;

      for (var moshaf in moshafList) {
        final surahList = moshaf['surah_list'];
        if (surahList != null) {
          final surahs = surahList.toString().split(',').map((e) => e.trim());
          if (surahs.contains(surahNumber.toString())) {
            return true;
          }
        }
      }

      return false;
    }).toList();

    return filtered.map((reciter) => AudioModel.fromJson(reciter, surahNumber)).toList();
  } else {
    throw Exception('فشل تحميل القراء');
  }
}

  Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/reciters'));

    if (response.statusCode == 200) {
      final List<dynamic> reciters = jsonDecode(response.body)['reciters'];
      var reciter = reciters.firstWhere((r) => r['id'] == reciterId, orElse: () => {});

      if (reciter.isNotEmpty && reciter.containsKey('moshaf')) {
        return AudioModel.fromJson(reciter, surahNumber);
      }
    }
    return null;
  }

  Future<String> getOrDownloadAudio(String audioUrl, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$filename';

    if (await File(filePath).exists()) {
      print('الصوت موجود لوكل');
      return filePath;
    }

    print('تحميل الصوت من ال api ');
    final response = await http.get(Uri.parse(audioUrl));

    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception(' فشل تحميل الصوت');
    }
  }
}
