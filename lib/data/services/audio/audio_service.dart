import 'package:http/http.dart' as http;
import '../../models/audio_mobel.dart';
import '../base_service.dart';
import 'audio_cache_helper.dart';
import 'audio_filter.dart';

class AudioService extends BaseService {
  static const String baseUrl = 'https://mp3quran.net/api/v3';
  static const String recitersEndpoint = '$baseUrl/reciters';

  Future<List<AudioModel>> fetchReciters() async {
    final recitersJson = await getListRequest(recitersEndpoint, 'reciters');
    return AudioFilter.mapToAudioModels(recitersJson, 1);
  }

  Future<List<AudioModel>> fetchRecitersWithSurah(int surahNumber) async {
    final cached = await AudioCacheHelper.getFromCache(surahNumber);
    if (cached.isNotEmpty) {
      return AudioFilter.mapToAudioModels(cached, surahNumber);
    }

    final allReciters = await _getAllReciters();
    final filtered = AudioFilter.filterRecitersBySurah(allReciters, surahNumber);

    await AudioCacheHelper.saveToCache(surahNumber, filtered);

    return AudioFilter.mapToAudioModels(filtered, surahNumber);
  }

  Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    final recitersJson = await getListRequest(recitersEndpoint, 'reciters');
    final reciter = recitersJson.firstWhere(
      (r) => r['id'] == reciterId,
      orElse: () => {},
    );

    if (reciter.isNotEmpty && reciter.containsKey('moshaf')) {
      return AudioModel.fromJson(reciter, surahNumber);
    }
    return null;
  }

  static Future<http.Response> fetchAudioFile(String url) async {
    return await http.get(Uri.parse(url));
  }

  Future<List<dynamic>> _getAllReciters() async {
    try {
      return await getListRequest(recitersEndpoint, 'reciters');
    } catch (_) {
      return [];
    }
  }
}
