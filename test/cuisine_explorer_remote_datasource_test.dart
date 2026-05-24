import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisines_explorer_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cucine_in_citta/src/core/network/api_client.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/shared/result.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient mockApiClient;

  late CuisineExplorerRemoteDatasource datasource;

  setUp(() {
    mockApiClient = MockApiClient();

    datasource = CuisineExplorerRemoteDatasource(mockApiClient);
  });

  group('searchCities', () {
    test('should return Success when API call succeeds', () async {
      final cities = [
        CityModel(
          id: 1,
          name: 'Milano',
          description: 'Milano, Lombardia, Italia',
          countryCode: 'IT',
          structuredFormatting: CityStructuredFormatting(
            main_text: 'Milano',
            secondary_text: 'Lombardia, Italia',
          ),
          latitude: 45.46,
          longitude: 9.17,
        ),
      ];

      when(
        () => mockApiClient.searchCities(any(), any(), any(), any()),
      ).thenAnswer((_) async => cities);

      final result = await datasource.searchCities('mil', 'it', 8);

      expect(result, isA<Success<List<CityModel>, Exception>>());

      final success = result as Success<List<CityModel>, Exception>;

      expect(success.value.first.name, 'Milano');

      verify(
        () => mockApiClient.searchCities('mil', 'it', 8, CancelToken()),
      ).called(1);
    });
    test('should return Failure when API throws', () async {
      when(
        () => mockApiClient.searchCities(any(), any(), any(), CancelToken()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      final result = await datasource.searchCities('mil', 'it', 8);

      expect(result, isA<Failure<List<CityModel>, Exception>>());
    });
  });
}
