
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/cuisines_explorer/data/models/city_model.dart';
import '../../features/cuisines_explorer/data/models/cuisine_response_model.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(
    Dio dio, {
    String baseUrl,
  }) = _ApiClient;

  @GET('/places/v2/autocomplete')
  Future<List<CityModel>> searchCities(
    @Query('term') String term,
    @Query('lang') String lang,
    @Query('limit') int limit,
  );

  @GET('/places/labels/by-location-and-type')
  Future<CuisineResponseModel> getCuisines(
    @Query('lat') double lat,
    @Query('lng') double lng,
    @Query('type') String type,
  );
}


