import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prayer_times_model.dart';

class PrayerTimesService {
  static const String baseUrl = 'https://api.aladhan.com/v1/timingsByCity';

  Future<PrayerTimesModel> fetchPrayerTimes(String city, String country) async {
    final today = DateTime.now();
    final dateString = '${today.day}-${today.month}-${today.year}';
final response = await http.get(Uri.parse('$baseUrl/$dateString?country=$country&city=$city'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PrayerTimesModel.fromJson(data['data']['timings']);
    } else {
      throw Exception('Failed to fetch prayer times.');
    }
  }
}

