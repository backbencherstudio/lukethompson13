// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitClaimRequest _$SubmitClaimRequestFromJson(Map<String, dynamic> json) =>
    SubmitClaimRequest(
      claimMethod: json['claim_method'] as String,
      recipientEmail: json['recipient_email'] as String?,
      brokerEmail: json['broker_email'] as String?,
    );

Map<String, dynamic> _$SubmitClaimRequestToJson(SubmitClaimRequest instance) =>
    <String, dynamic>{
      'claim_method': instance.claimMethod,
      'recipient_email': instance.recipientEmail,
      'broker_email': instance.brokerEmail,
    };
