import 'package:bloc_test/bloc_test.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisines_explorer_remote_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cucine_in_citta/src/core/errors/api_exception.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_response_model.dart';
import 'package:cucine_in_citta/src/shared/result.dart';

class MockCuisineExplorerRemoteDatasource extends Mock
    implements CuisineExplorerRemoteDatasource {}

void main() {
  late MockCuisineExplorerRemoteDatasource dataSource;

  const debounceDuration = Duration(milliseconds: 350);

  final city = CityModel(
    id: 8047,
    name: 'Milano',
    description: 'Milano, Lombardia, Italia',
    countryCode: 'IT',
    structuredFormatting: CityStructuredFormatting(
      main_text: 'Milano',
      secondary_text: 'Lombardia, Italia',
    ),
    latitude: 45.4612939,
    longitude: 9.172356290785304,
  );

  final cuisine = CuisineModel(
    id: 52,
    name: 'Cinese',
    nameIt: 'Cinese',
    nameEng: 'Chinese',
    nameEs: 'China',
    color: '#5B50A1',
    emoji: 'https://example.com/cinese.png',
    type: 'cuisine',
    engLabel: 'chinese',
  );

  final cuisineResponse = CuisineResponseModel(length: 1, data: [cuisine]);

  setUp(() {
    dataSource = MockCuisineExplorerRemoteDatasource();
  });

  group('CuisineExplorerCubit', () {
    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits ExplorerIdle when query has less than 2 characters',
      build: () => CuisineExplorerCubit(dataSource),
      act: (cubit) => cubit.onSearchChanged('m'),
      expect: () => [isA<ExplorerIdle>()],
      verify: (_) {
        verifyNever(() => dataSource.searchCities(any(), any(), any()));
      },
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits Searching and SuggestionsLoaded when city search succeeds',
      build: () {
        when(
          () => dataSource.searchCities('mil', 'it', 8),
        ).thenAnswer((_) async => Success([city]));

        return CuisineExplorerCubit(dataSource);
      },
      act: (cubit) => cubit.onSearchChanged('mil'),
      wait: debounceDuration,
      expect: () => [
        isA<ExplorerSearching>(),
        isA<ExplorerSuggestionsLoaded>(),
      ],
      verify: (_) {
        verify(() => dataSource.searchCities('mil', 'it', 8)).called(1);
      },
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits Searching and NoResults when city search returns empty list',
      build: () {
        when(
          () => dataSource.searchCities('xxx', 'it', 8),
        ).thenAnswer((_) async => const Success([]));

        return CuisineExplorerCubit(dataSource);
      },
      act: (cubit) => cubit.onSearchChanged('xxx'),
      wait: debounceDuration,
      expect: () => [isA<ExplorerSearching>(), isA<ExplorerNoResults>()],
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits SearchCitiesError when city search fails',
      build: () {
        when(() => dataSource.searchCities('mil', 'it', 8)).thenAnswer(
          (_) async => Failure(null, const ApiException('Search error')),
        );

        return CuisineExplorerCubit(dataSource);
      },
      act: (cubit) => cubit.onSearchChanged('mil'),
      wait: debounceDuration,
      expect: () => [isA<ExplorerSearching>(), isA<SearchCitiesError>()],
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits LoadingCuisines and CuisinesLoaded when cuisine search succeeds',
      build: () {
        when(
          () =>
              dataSource.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).thenAnswer((_) async => Success(cuisineResponse));

        return CuisineExplorerCubit(dataSource);
      },
      act: (cubit) => cubit.selectCity(city),
      expect: () => [
        isA<ExplorerLoadingCuisines>(),
        isA<ExplorerCuisinesLoaded>(),
      ],
      verify: (_) {
        verify(
          () =>
              dataSource.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).called(1);
      },
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits LoadingCuisines and EmptyCuisines when cuisine list is empty',
      build: () {
        when(
          () =>
              dataSource.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).thenAnswer(
          (_) async => Success(CuisineResponseModel(length: 0, data: [])),
        );

        return CuisineExplorerCubit(dataSource);
      },
      act: (cubit) => cubit.selectCity(city),
      expect: () => [
        isA<ExplorerLoadingCuisines>(),
        isA<ExplorerEmptyCuisines>(),
      ],
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits LoadingCuisines and SearchCuisinesError when cuisine search fails',
      build: () {
        when(
          () =>
              dataSource.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).thenAnswer(
          (_) async => Failure(null, const ApiException('Cuisine error')),
        );

        return CuisineExplorerCubit(dataSource);
      },
      act: (cubit) => cubit.selectCity(city),
      expect: () => [
        isA<ExplorerLoadingCuisines>(),
        isA<SearchCuisinesError>(),
      ],
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'ignores obsolete city search responses',
      build: () {
        when(
          () => dataSource.searchCities('mil', 'it', 8),
        ).thenAnswer((_) async => Success([city]));

        return CuisineExplorerCubit(dataSource);
      },
      act: (cubit) {
        cubit.onSearchChanged('mil');
        cubit.onSearchChanged('');
      },
      wait: debounceDuration,
      expect: () => [isA<ExplorerIdle>()],
    );
  });
}
