import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';

class CachedTokenNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setToken(String? token) => state = token;
}

final cachedTokenProvider = NotifierProvider<CachedTokenNotifier, String?>(
  CachedTokenNotifier.new,
);

final dioClientProvider = Provider<Dio>((ref) {
  final client = DioClient(
    baseUrl: ApiEndpoints.apiURL,
    interceptors: [
      AuthInterceptor(getToken: () => ref.read(cachedTokenProvider)),
      ApiSuccessInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ],
  );
  return client.dio;
});

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
         ),
       ) {
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
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
