import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  final Dio dio;

  DioClient({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    List<Interceptor>? interceptors,
  }) : dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout ?? const Duration(seconds: 10),
           receiveTimeout: receiveTimeout ?? const Duration(seconds: 10),
           validateStatus: (status) => status != null && status < 500,
         ),
       ) {
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
  }
}

class AuthInterceptor extends Interceptor {
  final String? Function() getToken;

  AuthInterceptor({required this.getToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class ApiSuccessInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (data is Map<String, dynamic> && data['success'] == false) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: data['message'] as String? ?? 'Request failed',
          type: DioExceptionType.badResponse,
        ),
      );
    } else {
      handler.next(response);
    }
  }
}

class CachedTokenNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setToken(String? token) => state = token;
}
