import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/audio_mobel.dart';

class AudioService {
  static const String baseUrl = 'https://mp3quran.net/api/v3';

  Future<void> fetchReciters() async {
    final response = await http.get(Uri.parse('$baseUrl/reciters'));

    if (response.statusCode == 200) {
      final List<dynamic> recitersJson = jsonDecode(response.body)['reciters'];

      if (recitersJson.isNotEmpty) {
        print('Fetched ${recitersJson.length} reciters:');
        for (var reciter in recitersJson) {
          print('Reciter: ${reciter['name']} - ID: ${reciter['id']}');
        }
      } else {
        print('No reciters found.');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<AudioModel?> fetchSurahAudio(int reciterId, int surahNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/reciters'));

    if (response.statusCode == 200) {
      final List<dynamic> reciters = jsonDecode(response.body)['reciters'];
      var reciter = reciters.firstWhere((r) => r['id'] == reciterId, orElse: () => {});

      if (reciter.isNotEmpty && reciter.containsKey('moshaf')) {
        final List<dynamic> moshafList = reciter['moshaf'];

        if (moshafList.isNotEmpty) {
          final moshaf = moshafList[0];

          return AudioModel.fromJson({
            'name': reciter['name'],
            'moshaf': [moshaf]
          }, surahNumber);
        }
      }
    }
    return null;
  }
}
