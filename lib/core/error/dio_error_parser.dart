import 'package:dio/dio.dart';

import 'exception.dart';

class ApiErrorHandler {
  static Exception onDioError(DioException e) {
    final response = e.response;
    final data = response?.data;

    final statusCode = response?.statusCode ?? 500;
    String? message;

    if (data is Map<String, dynamic>) {
      final apiError = data['error'];

      if (apiError is Map<String, dynamic>) {
        message = apiError['message']?.toString();
      }

      message ??= data['message']?.toString();
    }

    switch (statusCode) {
      case 400:
        return UnknownException(message: message ?? 'Bad Request');
      case 401:
        return InvalidCredentialsException();
      default:
        return UnknownException(
          message: message ?? e.message ?? 'Network error',
        );
    }
  }

  static Exception onError(Object e) {
    if (e is DioException) {
      return onDioError(e);
    } else {
      return UnknownException(message: e.toString());
    }
  }
}
