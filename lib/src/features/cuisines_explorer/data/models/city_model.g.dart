// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  countryCode: json['country_code'] as String,
  description: json['description'] as String,
  id: (json['id'] as num).toInt(),
  structuredFormatting: CityStructuredFormatting.fromJson(
    json['structured_formatting'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'country_code': instance.countryCode,
  'structured_formatting': instance.structuredFormatting.toJson(),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};

CityStructuredFormatting _$CityStructuredFormattingFromJson(
  Map<String, dynamic> json,
) => CityStructuredFormatting(
  main_text: json['main_text'] as String,
  secondary_text: json['secondary_text'] as String,
);

Map<String, dynamic> _$CityStructuredFormattingToJson(
  CityStructuredFormatting instance,
) => <String, dynamic>{
  'main_text': instance.main_text,
  'secondary_text': instance.secondary_text,
};
