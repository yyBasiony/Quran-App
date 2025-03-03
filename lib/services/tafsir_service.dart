import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tafsir_model.dart';

class TafsirService {
  Future<TafsirModel?> fetchTafsir(int surah, int ayah) async {
    String url = "https://api.alquran.cloud/v1/ayah/$surah:$ayah/editions/ar.muyassar";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return TafsirModel.fromJson(data['data'][0]);
      } else {
         print("Failed to load Tafsir: \${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: \$e");
      return null;
    }
  }
}
