import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/core/network/error_handle.dart';

final dioClientProvider = Provider<Dio>((ref) {
  final client = DioClient(
    baseUrl: ApiEndpoints.apiURL,
    interceptors: [
      ApiSuccessInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ],
  );
  return client.dio;
});

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
