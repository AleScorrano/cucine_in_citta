import 'package:cucine_in_citta/src/core/errors/api_exception.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisine_explorer_local_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisines_explorer_remote_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_response_model.dart';
import 'package:cucine_in_citta/src/shared/result.dart';
import 'package:dio/dio.dart';

class CuisineExplorerRepository {
  CuisineExplorerRepository(this._remoteDatasource, this._localDatasource);

  final CuisineExplorerRemoteDatasource _remoteDatasource;
  final CuisineExplorerLocalDatasource _localDatasource;

  Future<Result<List<CityModel>, ApiException>> searchCities(
    String term,
    String language,
    int limit, {
    CancelToken? cancelToken,
  }) => _remoteDatasource.searchCities(
    term,
    language,
    limit,
    cancelToken: cancelToken,
  );

  Future<Result<CuisineResponseModel, ApiException>> getCuisines(
    double lat,
    double lng,
    String type,
  ) => _remoteDatasource.getCuisines(lat, lng, type);

  List<CityModel> getRecentCities() {
    return _localDatasource.getRecentCities();
  }

  Future<void> saveRecentCity(CityModel city) async {
    final currentCities = _localDatasource.getRecentCities();

    final withoutSelectedCity = currentCities.where(
      (storedCity) => storedCity.id != city.id,
    );

    final updatedCities = [city, ...withoutSelectedCity].take(3).toList();

    await _localDatasource.saveRecentCities(updatedCities);
  }

  Future<void> deleteRecentCity(CityModel city) async =>
      _localDatasource.deleteCity(city);

  Future<void> deleteAllRecentCityes() async =>
      _localDatasource.clearRecentCities();
}
