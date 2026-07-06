import 'package:json_annotation/json_annotation.dart';

part 'claim.model.g.dart';

@JsonSerializable()
class ClaimEvent {
  final String? id;

  const ClaimEvent({this.id});

  factory ClaimEvent.fromJson(Map<String, dynamic> json) =>
      _$ClaimEventFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimEventToJson(this);

  @override
  String toString() => 'ClaimEvent${toJson()}';
}

@JsonSerializable()
class Claim {
  final String id;

  final String? status;

  final num? amount;

  @JsonKey(name: 'paid_amount')
  final num? paidAmount;

  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;

  @JsonKey(name: 'recipient_email')
  final String? recipientEmail;

  @JsonKey(name: 'recourse_level')
  final int? recourseLevel;

  @JsonKey(name: 'followup_count')
  final int? followupCount;

  @JsonKey(name: 'followup_due_at')
  final DateTime? followupDueAt;

  @JsonKey(name: 'claim_events')
  final List<ClaimEvent>? claimEvents;

  const Claim({
    required this.id,
    this.status,
    this.amount,
    this.paidAmount,
    this.sentAt,
    this.recipientEmail,
    this.recourseLevel,
    this.followupCount,
    this.followupDueAt,
    this.claimEvents,
  });

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);

  @override
  String toString() => 'Claim${toJson()}';
}
