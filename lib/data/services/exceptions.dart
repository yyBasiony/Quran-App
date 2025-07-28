import 'package:easy_localization/easy_localization.dart';

abstract class AppException implements Exception {
  final String translationKey;

  AppException(this.translationKey);

  String get message => translationKey.tr();
}

class NoInternetException extends AppException {
  NoInternetException() : super('no_internet');
}

class TimeoutException extends AppException {
  TimeoutException() : super('timeout');
}

class ApiException extends AppException {
  ApiException([int? statusCode])
      : super('errors.api_error.${statusCode ?? 'unknown'}');
}

class DataNotFoundException extends AppException {
  DataNotFoundException([String key = 'errors.data_not_found'])
      : super(key);
}

class ServerException extends AppException {
  ServerException() : super('server_error');
}

class NetworkException extends AppException {
  NetworkException() : super('errors.network_error');
}

class DataParsingException extends AppException {
  DataParsingException() : super('parsing_error');
}

class DataFormatException extends AppException {
  DataFormatException() : super('errors.invalid_format');
}

class UnknownException extends AppException {
  UnknownException([String key = 'generic']) : super(key);
}
