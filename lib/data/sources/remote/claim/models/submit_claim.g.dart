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

ClaimSubmitData _$ClaimSubmitDataFromJson(Map<String, dynamic> json) =>
    ClaimSubmitData(
      claimId: json['claim_id'] as String,
      status: $enumDecode(_$ClaimStatusEnumMap, json['status']),
      sentAt: json['sent_at'] == null
          ? null
          : DateTime.parse(json['sent_at'] as String),
      claimMessage: json['claim_message'] as String?,
    );

Map<String, dynamic> _$ClaimSubmitDataToJson(ClaimSubmitData instance) =>
    <String, dynamic>{
      'claim_id': instance.claimId,
      'status': _$ClaimStatusEnumMap[instance.status]!,
      'sent_at': instance.sentAt?.toIso8601String(),
      'claim_message': instance.claimMessage,
    };

const _$ClaimStatusEnumMap = {
  ClaimStatus.draft: 'DRAFT',
  ClaimStatus.submitted: 'SUBMITTED',
  ClaimStatus.paid: 'PAID',
  ClaimStatus.unpaid: 'UNPAID',
  ClaimStatus.denied: 'DENIED',
};

SubmitClaimResponse _$SubmitClaimResponseFromJson(Map<String, dynamic> json) =>
    SubmitClaimResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ClaimSubmitData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitClaimResponseToJson(
  SubmitClaimResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
