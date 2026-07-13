// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_a_claim_as_paid_request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkAClaimAsPaidRequest _$MarkAClaimAsPaidRequestFromJson(
  Map<String, dynamic> json,
) => MarkAClaimAsPaidRequest(
  paidAmount: (json['paid_amount'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MarkAClaimAsPaidRequestToJson(
  MarkAClaimAsPaidRequest instance,
) => <String, dynamic>{'paid_amount': ?instance.paidAmount};

MarkAClaimAsDeniedRequest _$MarkAClaimAsDeniedRequestFromJson(
  Map<String, dynamic> json,
) => MarkAClaimAsDeniedRequest(
  deniedBy: json['denied_by'] as String?,
  denialReason: json['denial_reason'] as String?,
);

Map<String, dynamic> _$MarkAClaimAsDeniedRequestToJson(
  MarkAClaimAsDeniedRequest instance,
) => <String, dynamic>{
  'denied_by': ?instance.deniedBy,
  'denial_reason': ?instance.denialReason,
};

SendClaimFollowUpEmailRequest _$SendClaimFollowUpEmailRequestFromJson(
  Map<String, dynamic> json,
) => SendClaimFollowUpEmailRequest(level: (json['level'] as num).toInt());

Map<String, dynamic> _$SendClaimFollowUpEmailRequestToJson(
  SendClaimFollowUpEmailRequest instance,
) => <String, dynamic>{'level': instance.level};
