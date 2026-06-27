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

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.phoneNumber,
    required this.createdAt,
    required this.type,
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

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() => 'LoginResponse${toJson()}';
}
