import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';

part 'single_stoplog.model.g.dart';

@JsonSerializable()
class DetensionSummaryPdf {
  final String id;

  @JsonKey(name: 'file_name')
  final String fileName;

  @JsonKey(name: 'file_url')
  final String? fileUrl;

  @JsonKey(name: 'mime_type')
  final String? mimeType;

  final String type;

  @JsonKey(name: 'size_bytes')
  final int? sizeBytes;

  DetensionSummaryPdf({
    required this.id,
    required this.fileName,
    this.fileUrl,
    this.mimeType,
    required this.type,
    this.sizeBytes,
  });

  factory DetensionSummaryPdf.fromJson(Map<String, dynamic> json) =>
      _$DetensionSummaryPdfFromJson(json);

  Map<String, dynamic> toJson() => _$DetensionSummaryPdfToJson(this);

  @override
  String toString() => 'DetensionSummaryPDF${toJson()}';
}

@JsonSerializable()
class SingleStoplogDetailData {
  final String? id;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'shipper_facility_id')
  final String? shipperFacilityId;

  @JsonKey(name: 'shipper_id')
  final String? shipperId;

  @JsonKey(name: 'shipper_name')
  final String? shipperName;

  @JsonKey(name: 'facility_name')
  final String? facilityName;

  @JsonKey(name: 'bol_number')
  final String? bolNumber;

  final SingleStoplogStatus? status;

  @JsonKey(name: 'arrived_at')
  final DateTime? arrivedAt;

  @JsonKey(name: 'docked_at')
  final DateTime? dockedAt;

  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  @JsonKey(name: 'departed_at')
  final DateTime? departedAt;

  @JsonKey(name: 'arrival_location')
  final StopLogLocation? arrivalLocation;

  @JsonKey(name: 'facility_address')
  final StopLogLocation? facilityAddress;

  final List<StopLogAttachment>? attachments;

  @JsonKey(name: 'recipient_email')
  final String? recipientEmail;

  final Claim? claim;

  @JsonKey(name: 'current_step', fromJson: StopLogStep.fromValue, toJson: null)
  final StopLogStep? currentStep;

  @JsonKey(name: 'detention_summary_pdf')
  final DetensionSummaryPdf? detentionSummaryPdf;

  // Available on stoplog completion
  @JsonKey(name: 'gps_coordinates')
  final GpsCoordinates? gpsCoordinates;
  @JsonKey(name: 'rate_per_hour')
  final String? ratePerHour;
  @JsonKey(name: 'free_wait_time')
  final String? freeWaitTime;
  @JsonKey(name: 'billable_time')
  final String? billableTime;
  @JsonKey(name: 'billable_time_text')
  final String? billableTimeText;
  @JsonKey(name: 'arrival_departure_time')
  final String? arrivalDepartureTime;
  final String? address;
  final String? detention;
  final String? lost;

  final StopLogBroker? broker;

  SingleStoplogDetailData({
    this.id,
    this.userId,
    this.shipperFacilityId,
    this.shipperId,
    this.shipperName,
    this.facilityName,
    this.bolNumber,
    this.status,
    this.arrivedAt,
    this.dockedAt,
    this.completedAt,
    this.departedAt,
    this.arrivalLocation,
    this.facilityAddress,
    this.attachments,
    this.detentionSummaryPdf,
    this.recipientEmail,
    this.claim,
    this.currentStep,
    this.gpsCoordinates,
    this.ratePerHour,
    this.freeWaitTime,
    this.billableTime,
    this.billableTimeText,
    this.arrivalDepartureTime,
    this.address,
    this.detention,
    this.lost,
    this.broker,
  });

  factory SingleStoplogDetailData.fromJson(Map<String, dynamic> json) =>
      _$SingleStoplogDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$SingleStoplogDetailDataToJson(this);

  @override
  String toString() => 'SingleStoplogData${toJson()}';
}

@JsonSerializable()
class SingleStoplogResponse extends BaseResponse {
  final SingleStoplogDetailData? data;

  SingleStoplogResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory SingleStoplogResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleStoplogResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleStoplogResponseToJson(this);

  @override
  String toString() => 'SingleStoplogResponse${toJson()}';
}

enum SingleStoplogStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('PROGRESS')
  progress,
}

@JsonSerializable()
class StopLogBroker {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? brokerId;
  final String? locationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StopLogBroker({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.brokerId,
    this.locationId,
    this.createdAt,
    this.updatedAt,
  });

  factory StopLogBroker.fromJson(Map<String, dynamic> json) =>
      _$StopLogBrokerFromJson(json);

  Map<String, dynamic> toJson() => _$StopLogBrokerToJson(this);
}

@JsonSerializable()
class GpsCoordinates {
  final double? lat;
  final double? lng;

  const GpsCoordinates({this.lat, this.lng});

  factory GpsCoordinates.fromJson(Map<String, dynamic> json) =>
      _$GpsCoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$GpsCoordinatesToJson(this);
}
