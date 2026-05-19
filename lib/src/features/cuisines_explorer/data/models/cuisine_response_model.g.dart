// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuisine_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuisineResponseModel _$CuisineResponseModelFromJson(
  Map<String, dynamic> json,
) => CuisineResponseModel(
  length: (json['length'] as num).toInt(),
  data: (json['data'] as List<dynamic>)
      .map((e) => CuisineModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CuisineResponseModelToJson(
  CuisineResponseModel instance,
) => <String, dynamic>{'length': instance.length, 'data': instance.data};
