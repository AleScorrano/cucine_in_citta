// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuisine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuisineModel _$CuisineModelFromJson(Map<String, dynamic> json) => CuisineModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  nameIt: json['name_it'] as String,
  nameEng: json['name_eng'] as String,
  nameEs: json['name_es'] as String,
  color: json['color'] as String,
  emoji: json['image_emoji'] as String,
  type: json['type'] as String,
  engLabel: json['eng_label'] as String,
);

Map<String, dynamic> _$CuisineModelToJson(CuisineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_it': instance.nameIt,
      'name_eng': instance.nameEng,
      'name_es': instance.nameEs,
      'color': instance.color,
      'image_emoji': instance.emoji,
      'type': instance.type,
      'eng_label': instance.engLabel,
    };
