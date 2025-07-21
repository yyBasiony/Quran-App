import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connectivity_service.dart';

abstract class BaseService {
  Future<Map<String, dynamic>> getRequest(String url) async {
    // Check connectivity 
    final hasConnection = await ConnectivityService.hasInternetConnection();
    if (!hasConnection) {
      throw NoInternetException('noInternetConnection');
    }
        
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('connectionTimeout'), 
      );
        
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        throw DataNotFoundException('dataNotFound'); 
      } else if (response.statusCode >= 500) {
        throw ServerException('serverError');
      } else {
        throw ApiException('apiError_${response.statusCode}'); 
      }
} on http.ClientException catch (e) {
  print('ClientException: $e');
  throw NetworkException('networkError');
} on FormatException catch (e) {
  print('FormatException: $e');
  throw DataParsingException('dataParsingError');    } catch (e) {
      if (e is NoInternetException || 
          e is TimeoutException || 
          e is ApiException ||
          e is DataNotFoundException ||
          e is ServerException ||
          e is NetworkException ||
          e is DataParsingException) {
        rethrow;
      }
      throw UnknownException('unknownError');
    }
  }

  Future<List<dynamic>> getListRequest(String url, String key) async {
    final json = await getRequest(url);
    if (json.containsKey(key)) {
      final data = json[key];
      if (data is List) {
        return data;
      } else {
        throw DataFormatException('invalidDataFormat');
      }
    } else {
      throw DataNotFoundException('keyNotFound'); 
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
          continue;
        } else {
          rethrow;
        }
      }
    }
    throw UnknownException('maxRetriesExceeded');
  }
}

class NoInternetException implements Exception {
  final String key;
  NoInternetException(this.key);
  
  @override
  String toString() => 'NoInternetException: $key';
}

class TimeoutException implements Exception {
  final String key;
  TimeoutException(this.key);
  
  @override
  String toString() => 'TimeoutException: $key';
}

class ApiException implements Exception {
  final String key;
  ApiException(this.key);
  
  @override
  String toString() => 'ApiException: $key';
}

class DataNotFoundException implements Exception {
  final String key;
  DataNotFoundException(this.key);
  
  @override
  String toString() => 'DataNotFoundException: $key';
}

// exception classes
class ServerException implements Exception {
  final String key;
  ServerException(this.key);
  
  @override
  String toString() => 'ServerException: $key';
}

class NetworkException implements Exception {
  final String key;
  NetworkException(this.key);
  
  @override
  String toString() => 'NetworkException: $key';
}

class DataParsingException implements Exception {
  final String key;
  DataParsingException(this.key);
  
  @override
  String toString() => 'DataParsingException: $key';
}

class DataFormatException implements Exception {
  final String key;
  DataFormatException(this.key);
  
  @override
  String toString() => 'DataFormatException: $key';
}

class UnknownException implements Exception {
  final String key;
  UnknownException(this.key);
  
  @override
  String toString() => 'UnknownException: $key';
}