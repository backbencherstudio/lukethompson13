import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/core/network/dio_client.dart';

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

final cachedTokenProvider = NotifierProvider<CachedTokenNotifier, String?>(
  CachedTokenNotifier.new,
);
