import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_response_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/result.dart';

import '../models/city_model.dart';

class CuisineExplorerRemoteDatasource {
  final ApiClient api;

  CuisineExplorerRemoteDatasource(this.api);

  Future<Result<List<CityModel>, ApiException>> searchCities(
    String term,
    String language,
    int limit
  ) async {
    try {
      final res = await api.searchCities(term, language, limit);
      return Success(res);
    } on DioException catch (e) {
      return Failure(null, ApiException(e.message ?? 'error'));
    }
  }

  Future<Result<CuisineResponseModel, ApiException>> getCuisines(
    double lat,
    double lng,
    String type,
  ) async {
    try {
      final res = await api.getCuisines(lat, lng, type);
      return Success(res);
    } on DioException catch (e) {
      return Failure(null, ApiException(e.message ?? 'error'));
    }
  }
}