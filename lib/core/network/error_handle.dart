import 'package:dio/dio.dart';

class ErrorHandle {
  static String handleDioError(DioException e) {
    final responseData = e.response?.data;
    final serverMessage = _extractMessage(responseData) ?? e.message;
    final statusCode = e.response?.statusCode;

    if (serverMessage != null && serverMessage.isNotEmpty) {
      return serverMessage;
    }

    switch (e.type) {
      case DioExceptionType.badCertificate:
        return "Bad certificate. Please try again.";
      case DioExceptionType.badResponse:
        if (statusCode == 404) {
          return "No data found.";
        }
        if (statusCode == 401 || statusCode == 403) {
          return "You are not authorized to access this data.";
        }
        if (statusCode != null) {
          return "Unable to load data right now.";
        }
        return "Something went wrong. Please try again.";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "Connection error. Please check your internet.";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Send timeout. Please try again.";
      case DioExceptionType.unknown:
        return "Unknown error occurred. Please try again.";
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map) {
      final message = data['message'];
      if (message != null) {
        return message.toString();
      }
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return null;
  }

  static String extractServerMessage(Object error) {
    if (error is DioException) {
      return _extractMessage(error.response?.data) ?? error.toString();
    }
    return error.toString();
  }

  static String formatErrorMessage(Object error) {
    if (error is DioException) {
      return handleDioError(error);
    }

    var rawMessage = error.toString().trim();

    if (rawMessage.startsWith('Exception: ')) {
      rawMessage = rawMessage.substring('Exception: '.length).trim();
    }

    if (rawMessage.startsWith('DioException')) {
      final colonIdx = rawMessage.indexOf(':');
      if (colonIdx != -1) {
        return rawMessage.substring(colonIdx + 1).trim();
      }
      return "Connection error. Please check your internet.";
    }

    if (rawMessage.toLowerCase().contains('failed to load') ||
        rawMessage.toLowerCase().contains('server error')) {
      return "No data found.";
    }

    return rawMessage;
  }
}
