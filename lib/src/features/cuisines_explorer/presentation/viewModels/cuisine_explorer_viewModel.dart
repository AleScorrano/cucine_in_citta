import 'package:cucine_in_citta/src/features/cuisines_explorer/di/cuisine_explorer_providers.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/viewModels/cuisine_explorer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/debounce.dart';
import '../../data/models/city_model.dart';

class CuisineExplorerViewModel extends Notifier<CuisineExplorerState> {
  late final _dataSource = ref.read(cuisineExplorerDataSourceProvider);

  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  String? _lastQuery;
  CityModel? _lastCitySelected;

  int _activeRequestId = 0;

  @override
  CuisineExplorerState build() {
    ref.onDispose(_debouncer.dispose);

    return const ExplorerIdle();
  }

  void resetState() {
    state = const ExplorerIdle();
  }

  void retryCuisineSearch() {
    final city = _lastCitySelected;
    if (city == null) return;

    selectCity(city);
  }

  void retryLastSearch() {
    final query = _lastQuery;
    if (query == null) return;

    onSearchChanged(query);
  }

  void onSearchChanged(String text) {
    final query = text.trim();

    final requestId = ++_activeRequestId;

    if (query.length < 2) {
      state = const ExplorerIdle();
      return;
    }

    _lastQuery = query;

    _debouncer(() async {
      if (requestId != _activeRequestId) return;

      state = const ExplorerSearching();

      final result = await _dataSource.searchCities(query, 'it', 8);

      if (requestId != _activeRequestId) return;

      result.match(
        (exception) {
          state = SearchCitiesError(exception.message);
        },
        (cities) {
          if (cities.isEmpty) {
            state = const ExplorerNoResults();
          } else {
            state = ExplorerSuggestionsLoaded(cities);
          }
        },
      );
    });
  }

  Future<void> selectCity(CityModel city) async {
    _activeRequestId++;
    _debouncer.cancel();

    _lastCitySelected = city;

    state = const ExplorerLoadingCuisines();

    final result = await _dataSource.getCuisines(
      city.latitude,
      city.longitude,
      'cuisine',
    );

    result.match(
      (exception) {
        state = SearchCuisinesError(exception.message);
      },
      (cuisines) {
        if (cuisines.data.isEmpty) {
          state = const ExplorerEmptyCuisines();
        } else {
          state = ExplorerCuisinesLoaded(city, cuisines);
        }
      },
    );
  }
}
