import 'package:json_annotation/json_annotation.dart';

part 'mark_a_claim_as_paid_request.model.g.dart';

@JsonSerializable()
class MarkAClaimAsPaidRequest {
  @JsonKey(name: 'paid_amount')
  final double? paidAmount;

  const MarkAClaimAsPaidRequest({this.paidAmount});
}
