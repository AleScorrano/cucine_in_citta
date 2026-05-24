import 'package:bloc_test/bloc_test.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/repository/cuisine_explorer_repository.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cucine_in_citta/src/core/errors/api_exception.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_response_model.dart';
import 'package:cucine_in_citta/src/shared/result.dart';

class MockCuisineExplorerRepository extends Mock
    implements CuisineExplorerRepository {}

void main() {
  late MockCuisineExplorerRepository repository;

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

  setUpAll(() {
    registerFallbackValue(CancelToken());
  });

  setUp(() {
    repository = MockCuisineExplorerRepository();

    when(() => repository.getRecentCities()).thenReturn([]);
    when(() => repository.saveRecentCity(city)).thenAnswer((_) async {});
  });

  group('CuisineExplorerCubit', () {
    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits ExplorerIdle when query has less than 2 characters',
      build: () => CuisineExplorerCubit(repository),
      act: (cubit) => cubit.onSearchChanged('m'),
      expect: () => [isA<ExplorerIdle>()],
      verify: (_) {
        verifyNever(
          () => repository.searchCities(
            any(),
            any(),
            any(),
            cancelToken: any(named: 'cancelToken'),
          ),
        );
      },
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits Searching and SuggestionsLoaded when city search succeeds',
      build: () {
        when(
          () => repository.searchCities(
            'mil',
            'it',
            8,
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => Success([city]));

        return CuisineExplorerCubit(repository);
      },
      act: (cubit) => cubit.onSearchChanged('mil'),
      wait: debounceDuration,
      expect: () => [
        isA<ExplorerSearching>(),
        isA<ExplorerSuggestionsLoaded>(),
      ],
      verify: (_) {
        verify(
          () => repository.searchCities(
            'mil',
            'it',
            8,
            cancelToken: any(named: 'cancelToken'),
          ),
        ).called(1);
      },
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits Searching and NoResults when city search returns empty list',
      build: () {
        when(
          () => repository.searchCities(
            'xxx',
            'it',
            8,
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => const Success([]));

        return CuisineExplorerCubit(repository);
      },
      act: (cubit) => cubit.onSearchChanged('xxx'),
      wait: debounceDuration,
      expect: () => [isA<ExplorerSearching>(), isA<ExplorerNoResults>()],
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits SearchCitiesError when city search fails',
      build: () {
        when(
          () => repository.searchCities(
            'mil',
            'it',
            8,
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer(
          (_) async => Failure<List<CityModel>, ApiException>(
            null,
            const ApiException('Search error'),
          ),
        );

        return CuisineExplorerCubit(repository);
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
              repository.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).thenAnswer((_) async => Success(cuisineResponse));

        return CuisineExplorerCubit(repository);
      },
      act: (cubit) => cubit.selectCity(city),
      expect: () => [
        isA<ExplorerLoadingCuisines>(),
        isA<ExplorerCuisinesLoaded>(),
      ],
      verify: (_) {
        verify(() => repository.saveRecentCity(city)).called(1);
        verify(
          () =>
              repository.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).called(1);
      },
    );

    blocTest<CuisineExplorerCubit, CuisineExplorerState>(
      'emits LoadingCuisines and EmptyCuisines when cuisine list is empty',
      build: () {
        when(
          () =>
              repository.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).thenAnswer(
          (_) async => Success(CuisineResponseModel(length: 0, data: [])),
        );

        return CuisineExplorerCubit(repository);
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
              repository.getCuisines(city.latitude, city.longitude, 'cuisine'),
        ).thenAnswer(
          (_) async => Failure<CuisineResponseModel, ApiException>(
            null,
            const ApiException('Cuisine error'),
          ),
        );

        return CuisineExplorerCubit(repository);
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
          () => repository.searchCities(
            'mil',
            'it',
            8,
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => Success([city]));

        return CuisineExplorerCubit(repository);
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
