import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/base.model.dart';

part 'auth.model.g.dart';

@JsonSerializable()
class Authorization {
  final String type;
  @JsonKey(name: 'access_token')
  final String accessToken;

  Authorization({required this.type, required this.accessToken});

  factory Authorization.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationToJson(this);

  @override
  String toString() => 'Authorization${toJson()}';
}

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String type;
  @JsonKey(name: 'rate_per_hour')
  final int? ratePerHour;
  @JsonKey(name: 'free_wait_time')
  final int? freeWaitTime;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.phoneNumber,
    required this.createdAt,
    required this.type,
    this.ratePerHour,
    this.freeWaitTime,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User${toJson()}';
}

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  @JsonKey(name: 'free_wait_time')
  final int? freeWaitTime;
  @JsonKey(name: 'rate_per_hour')
  final int? ratePerHour;
  final String type;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    this.freeWaitTime,
    this.ratePerHour,
    required this.type,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class VerifyEmailRequest {
  final String email;
  final String token;

  VerifyEmailRequest({required this.email, required this.token});

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestToJson(this);
}

@JsonSerializable()
class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}

@JsonSerializable()
class CheckOtpRequest {
  final String email;
  final String otp;

  CheckOtpRequest({required this.email, required this.otp});

  factory CheckOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOtpRequestToJson(this);
}

@JsonSerializable()
class LoginResponse extends BaseResponse {
  final Authorization? authorization;
  final User? user;

  LoginResponse({
    required super.success,
    required super.message,
    this.authorization,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() => 'LoginResponse${toJson()}';
}

@JsonSerializable()
class GetMeResponse extends BaseResponse {
  final User? data;

  GetMeResponse({required super.success, required super.message, this.data});

  factory GetMeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMeResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetMeResponseToJson(this);

  @override
  String toString() => 'GetMeResponse${toJson()}';
}
