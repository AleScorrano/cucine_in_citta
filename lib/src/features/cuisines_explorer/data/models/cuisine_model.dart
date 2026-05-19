import 'package:json_annotation/json_annotation.dart';

part 'cuisine_model.g.dart';

@JsonSerializable()
class CuisineModel {
  final int id;
  final String name;
  @JsonKey(name: 'name_it')
  final String nameIt;
  @JsonKey(name: 'name_eng')
  final String nameEng;
  @JsonKey(name: 'name_es')
  final String nameEs;
  final String color;
  @JsonKey(name: 'image_emoji')
  final String emoji;
  final String type;
  @JsonKey(name: 'eng_label')
  final String engLabel;

  CuisineModel({
    required this.id,
    required this.name,
    required this.nameIt,
    required this.nameEng,
    required this.nameEs,
    required this.color,
    required this.emoji,
    required this.type,
    required this.engLabel,
  });

  factory CuisineModel.fromJson(Map<String, dynamic> json) =>
      _$CuisineModelFromJson(json);

  Map<String, dynamic> toJson() => _$CuisineModelToJson(this);
}