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
         ),
       ) {
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }
  }
}

final dioClientProvider = Provider<Dio>((ref) {
  final client = DioClient(
    baseUrl: "https://jsonplaceholder.typicode.com",
    interceptors: [LogInterceptor(requestBody: true, responseBody: true)],
  );
  return client.dio;
});
