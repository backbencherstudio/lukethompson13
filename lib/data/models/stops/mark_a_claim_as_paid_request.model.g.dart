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
) => <String, dynamic>{'paid_amount': instance.paidAmount};
