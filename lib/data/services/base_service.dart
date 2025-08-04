import 'dart:convert';
import 'package:http/http.dart' as http;
import '../connectivity_helper.dart';
import 'connectivity_service.dart';
import 'exceptions.dart';

abstract class BaseService {
  Future<Map<String, dynamic>> getRequest(String url) async {
    final hasConnection = await ConnectivityService.hasInternetConnection();
    if (!hasConnection) {
      throw NoInternetException();
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException(),
      );

      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body);
        case 404:
          throw DataNotFoundException();
        case >= 500:
          throw ServerException();
        default:
          throw ApiException(response.statusCode);
      }
    } on http.ClientException {
      throw NetworkException();
    } on FormatException {
      throw DataParsingException();
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw UnknownException();
    }
  }

  Future<List<dynamic>> getListRequest(String url, String key) async {
    final json = await getRequest(url);
    if (json.containsKey(key)) {
      final data = json[key];
      if (data is List) {
        return data;
      } else {
        throw DataFormatException();
      }
    } else {
      throw DataNotFoundException('errors.key_not_found');
    }
  }

  Future<T> withRetry<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        return await operation();
      } catch (e) {
        attempts++;
        if (attempts >= maxRetries) rethrow;

        if (e is NetworkException || e is TimeoutException) {
          await Future.delayed(delay * attempts);
        } else {
          rethrow;
        }
      }
    }
    throw UnknownException('errors.max_retries');
  }
  Future<void> checkInternetOrThrow() async {
    final hasInternet = await ConnectivityHelper.hasInternet();
    if (!hasInternet) throw Exception("noInternetMessage");
  }

}
