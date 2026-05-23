import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_response_model.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/network/api_client.dart';
import '../models/city_model.dart';

class CuisineExplorerRemoteDatasource {
  final ApiClient api;

  CuisineExplorerRemoteDatasource(this.api);

  Future<Either<ApiException, List<CityModel>>> searchCities(
    String term,
    String language,
    int limit,
  ) async {
    try {
      final response = await api.searchCities(term, language, limit);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(e.message ?? "Error"));
    }
  }

  Future<Either<ApiException, CuisineResponseModel>> getCuisines(
    double lat,
    double lng,
    String type,
  ) async {
    try {
      final response = await api.getCuisines(lat, lng, type);
      return right(response);
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'error'));
    }
  }
}
