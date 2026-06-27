import 'package:dio/dio.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/data/models/auth.model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth.api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(ApiEndpoints.login)
  Future<LoginResponse> login(@Body() LoginRequest body);
}
