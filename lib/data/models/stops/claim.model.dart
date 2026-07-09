import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/stops/stop_log_list_response.model.dart';

part 'claim.model.g.dart';

@JsonEnum(valueField: 'value')
enum SendMethod {
  email('EMAIL', 'Email'),
  sms('SMS', 'SMS');

  final String label;
  final String value;
  const SendMethod(this.value, this.label);

  String get apiValue => value;
}

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

  final ClaimStatus? status;

  @JsonKey(name: 'send_method')
  final SendMethod? sendMethod;

  final num? amount;

  @JsonKey(name: 'paid_amount')
  final num? paidAmount;

  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;

  @JsonKey(name: 'recipient_email')
  final String? recipientEmail;

  @JsonKey(name: 'level')
  final int? level;

  @JsonKey(name: 'level_name')
  final String? levelName;

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
    this.level,
    this.levelName,
    this.recourseLevel,
    this.followupCount,
    this.followupDueAt,
    this.claimEvents,
    this.sendMethod,
  });

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimToJson(this);

  @override
  String toString() => 'Claim${toJson()}';
}
