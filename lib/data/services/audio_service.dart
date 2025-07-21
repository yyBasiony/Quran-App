import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/audio_mobel.dart';
import 'base_service.dart';

class AudioService extends BaseService {
  static const String baseUrl = 'https://mp3quran.net/api/v3';

  Future<List<AudioModel>> fetchReciters() async {
    final recitersJson = await getListRequest('$baseUrl/reciters', 'reciters');
    return recitersJson.map((reciter) => AudioModel.fromJson(reciter, 1)).toList();
  }

  Future<List<AudioModel>> fetchRecitersWithSurah(int surahNumber) async {
    final recitersJson = await getListRequest('$baseUrl/reciters', 'reciters');
    final filtered = recitersJson.where((reciter) {
      final moshafList = reciter['moshaf'] as List<dynamic>?;
      if (moshafList == null || moshafList.isEmpty) return false;
      return moshafList.any((moshaf) {
        final surahList = moshaf['surah_list'];
        if (surahList == null) return false;
        final surahs = surahList.toString().split(',').map((e) => e.trim());
        return surahs.contains(surahNumber.toString());
      });
    }).toList();

    return filtered.map((reciter) {
      try {
        return AudioModel.fromJson(reciter as Map<String, dynamic>, surahNumber);
      } catch (_) {
        return null;
      }
    }).whereType<AudioModel>().toList();
  }

  Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    final recitersJson = await getListRequest('$baseUrl/reciters', 'reciters');
    var reciter = recitersJson.firstWhere((r) => r['id'] == reciterId, orElse: () => {});
    if (reciter.isNotEmpty && reciter.containsKey('moshaf')) {
      return AudioModel.fromJson(reciter, surahNumber);
    }
    return null;
  }

  Future<String> getOrDownloadAudio(String audioUrl, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$filename';
    
    if (await File(filePath).exists()) {
      return filePath;
    }

    final response = await http.get(Uri.parse(audioUrl));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Failed to download audio');
    }
  }
}