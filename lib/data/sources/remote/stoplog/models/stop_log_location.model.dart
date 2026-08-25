import 'package:json_annotation/json_annotation.dart';

part 'stop_log_location.model.g.dart';

double? _parseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

@JsonSerializable()
class StopLogLocation {
  final String? city;
  final String? state;
  final String? country;
  final String? address;
  final String? zip;

  @JsonKey(fromJson: _parseDouble)
  final double? lat;

  @JsonKey(fromJson: _parseDouble)
  final double? lng;

  StopLogLocation({
    this.city,
    this.state,
    this.country,
    this.address,
    this.zip,
    this.lat,
    this.lng,
  });

  factory StopLogLocation.fromJson(Map<String, dynamic> json) =>
      _$StopLogLocationFromJson(json);

  Map<String, dynamic> toJson() => _$StopLogLocationToJson(this);

  @override
  String toString() => 'StopLogLocation${toJson()}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopLogLocation &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          state == other.state &&
          country == other.country &&
          address == other.address &&
          zip == other.zip &&
          lat == other.lat &&
          lng == other.lng;

  @override
  int get hashCode => Object.hash(city, state, country, address, zip, lat, lng);
}
