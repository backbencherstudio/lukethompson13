// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_log_location.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopLogLocation _$StopLogLocationFromJson(Map<String, dynamic> json) =>
    StopLogLocation(
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      address: json['address'] as String?,
      zip: json['zip'] as String?,
      lat: _parseDouble(json['lat']),
      lng: _parseDouble(json['lng']),
    );

Map<String, dynamic> _$StopLogLocationToJson(StopLogLocation instance) =>
    <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'address': instance.address,
      'zip': instance.zip,
      'lat': instance.lat,
      'lng': instance.lng,
    };
