import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connectivity_service.dart';

abstract class BaseService {
  Future<Map<String, dynamic>> getRequest(String url) async {
    // Check connectivity 
    final hasConnection = await ConnectivityService.hasInternetConnection();
    if (!hasConnection) {
      throw NoInternetException('لا يوجد اتصال بالإنترنت');
    }
    
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw TimeoutException('انتهت مهلة الاتصال'),
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ApiException('فشل الاتصال: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getListRequest(String url, String key) async {
    final json = await getRequest(url);
    if (json.containsKey(key)) {
      return json[key] as List<dynamic>;
    } else {
      throw DataNotFoundException('البيانات غير موجودة في الـ API');
    }
  }
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException(this.message);
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}

class DataNotFoundException implements Exception {
  final String message;
  DataNotFoundException(this.message);
}
