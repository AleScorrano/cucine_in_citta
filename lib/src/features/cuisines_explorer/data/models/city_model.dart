import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  final int id;
  final String name;
  final String description;
  @JsonKey(name: 'country_code')
  final String countryCode;
  @JsonKey(name: 'structured_formatting')
  final CityStructuredFormatting structuredFormatting;
  final double latitude;
  final double longitude;

  CityModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    required this.description,
    required this.id,
    required this.structuredFormatting,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}


@JsonSerializable()
class CityStructuredFormatting {
  final String main_text;
  final String secondary_text;

  CityStructuredFormatting({required this.main_text,required this.secondary_text,});

    factory CityStructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$CityStructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$CityStructuredFormattingToJson(this);
}