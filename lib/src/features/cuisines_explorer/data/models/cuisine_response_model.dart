import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'cuisine_response_model.g.dart';

@JsonSerializable()
class CuisineResponseModel {
  final int length;
  final List<CuisineModel> data;

  CuisineResponseModel({required this.length, required this.data,});

  factory CuisineResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CuisineResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CuisineResponseModelToJson(this);
}