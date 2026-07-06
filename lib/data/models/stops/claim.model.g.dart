// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimEvent _$ClaimEventFromJson(Map<String, dynamic> json) =>
    ClaimEvent(id: json['id'] as String?);

Map<String, dynamic> _$ClaimEventToJson(ClaimEvent instance) =>
    <String, dynamic>{'id': instance.id};

Claim _$ClaimFromJson(Map<String, dynamic> json) => Claim(
  id: json['id'] as String,
  status: json['status'] as String?,
  amount: json['amount'] as num?,
  paidAmount: json['paid_amount'] as num?,
  sentAt: json['sent_at'] == null
      ? null
      : DateTime.parse(json['sent_at'] as String),
  recipientEmail: json['recipient_email'] as String?,
  recourseLevel: (json['recourse_level'] as num?)?.toInt(),
  followupCount: (json['followup_count'] as num?)?.toInt(),
  followupDueAt: json['followup_due_at'] == null
      ? null
      : DateTime.parse(json['followup_due_at'] as String),
  claimEvents: (json['claim_events'] as List<dynamic>?)
      ?.map((e) => ClaimEvent.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'amount': instance.amount,
  'paid_amount': instance.paidAmount,
  'sent_at': instance.sentAt?.toIso8601String(),
  'recipient_email': instance.recipientEmail,
  'recourse_level': instance.recourseLevel,
  'followup_count': instance.followupCount,
  'followup_due_at': instance.followupDueAt?.toIso8601String(),
  'claim_events': instance.claimEvents,
};
