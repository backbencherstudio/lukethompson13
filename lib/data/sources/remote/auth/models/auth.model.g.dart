// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authorization _$AuthorizationFromJson(Map<String, dynamic> json) =>
    Authorization(
      type: json['type'] as String,
      accessToken: json['access_token'] as String,
    );

Map<String, dynamic> _$AuthorizationToJson(Authorization instance) =>
    <String, dynamic>{
      'type': instance.type,
      'access_token': instance.accessToken,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  avatar: json['avatar'] as String?,
  phoneNumber: json['phone_number'] as String?,
  createdAt: json['created_at'] as String,
  type: json['type'] as String,
  ratePerHour: (json['rate_per_hour'] as num?)?.toInt(),
  freeWaitTime: (json['free_wait_time'] as num?)?.toInt(),
  company: json['company'] == null
      ? null
      : Company.fromJson(json['company'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'avatar': instance.avatar,
  'phone_number': instance.phoneNumber,
  'created_at': instance.createdAt,
  'type': instance.type,
  'rate_per_hour': instance.ratePerHour,
  'free_wait_time': instance.freeWaitTime,
  'company': instance.company,
};

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      freeWaitTime: (json['free_wait_time'] as num?)?.toInt(),
      ratePerHour: (json['rate_per_hour'] as num?)?.toInt(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'free_wait_time': instance.freeWaitTime,
      'rate_per_hour': instance.ratePerHour,
      'type': instance.type,
    };

VerifyEmailRequest _$VerifyEmailRequestFromJson(Map<String, dynamic> json) =>
    VerifyEmailRequest(
      email: json['email'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VerifyEmailRequestToJson(VerifyEmailRequest instance) =>
    <String, dynamic>{'email': instance.email, 'token': instance.token};

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordRequest(email: json['email'] as String);

Map<String, dynamic> _$ForgotPasswordRequestToJson(
  ForgotPasswordRequest instance,
) => <String, dynamic>{'email': instance.email};

CheckOtpRequest _$CheckOtpRequestFromJson(Map<String, dynamic> json) =>
    CheckOtpRequest(
      email: json['email'] as String,
      otp: json['token'] as String,
    );

Map<String, dynamic> _$CheckOtpRequestToJson(CheckOtpRequest instance) =>
    <String, dynamic>{'email': instance.email, 'token': instance.otp};

ResetPasswordRequest _$ResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequest(
  email: json['email'] as String,
  token: json['token'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestToJson(
  ResetPasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'token': instance.token,
  'password': instance.password,
};

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      authorization: json['authorization'] == null
          ? null
          : Authorization.fromJson(
              json['authorization'] as Map<String, dynamic>,
            ),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'authorization': instance.authorization,
      'user': instance.user,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
  companyName: json['company_name'] as String,
  contactName: json['contact_name'] as String,
  phoneNumber: json['phone_number'] as String,
  email: json['email'] as String,
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
  'company_name': instance.companyName,
  'contact_name': instance.contactName,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'address': instance.address,
};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  addressLine1: json['address_line1'] as String,
  addressLine2: json['address_line2'] as String?,
  city: json['city'] as String,
  state: json['state'] as String,
  postalCode: json['postal_code'] as String,
  country: json['country'] as String,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'address_line1': instance.addressLine1,
  'address_line2': instance.addressLine2,
  'city': instance.city,
  'state': instance.state,
  'postal_code': instance.postalCode,
  'country': instance.country,
};

CreateCompanyRequest _$CreateCompanyRequestFromJson(
  Map<String, dynamic> json,
) => CreateCompanyRequest(
  companyName: json['company_name'] as String?,
  contactName: json['contact_name'] as String?,
  addressLine1: json['address_line1'] as String?,
  addressLine2: json['address_line2'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  postalCode: json['postal_code'] as String?,
  country: json['country'] as String?,
  phoneNumber: json['phone_number'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$CreateCompanyRequestToJson(
  CreateCompanyRequest instance,
) => <String, dynamic>{
  'company_name': instance.companyName,
  'contact_name': instance.contactName,
  'address_line1': instance.addressLine1,
  'address_line2': instance.addressLine2,
  'city': instance.city,
  'state': instance.state,
  'postal_code': instance.postalCode,
  'country': instance.country,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
};

GetMeResponse _$GetMeResponseFromJson(Map<String, dynamic> json) =>
    GetMeResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMeResponseToJson(GetMeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
