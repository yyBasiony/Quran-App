import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class BaseService {
  Future<Map<String, dynamic>> getRequest(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('فشل الاتصال: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getListRequest(String url, String key) async {
    final json = await getRequest(url);
    if (json.containsKey(key)) {
      return json[key] as List<dynamic>;
    } else {
      throw Exception('البيانات غير موجودة في الـ API');
    }
  }
}
