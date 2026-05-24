import 'package:cucine_in_citta/src/features/cuisines_explorer/data/repository/cuisine_explorer_repository.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../shared/result.dart';
import '../../data/models/city_model.dart';

class CuisineExplorerCubit extends Cubit<CuisineExplorerState> {
  CuisineExplorerCubit(this._repository) : super(const ExplorerIdle());

  final CuisineExplorerRepository _repository;

  /// Debounce per evitare chiamate API
  /// ad ogni keystroke.
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  String? _lastQuery;
  CityModel? _lastCitySelected;

  CancelToken? _searchCancelToken;

  void resetState() {
    emit(const ExplorerIdle());
  }

  List<CityModel> getRecentCities() => _repository.getRecentCities();

  Future<void> deleteRecentCity(CityModel city) async {
    await _repository.deleteRecentCity(city);
    emit(ExplorerIdle());
  }

  Future<void> deleteAllRecentCities() async {
    await _repository.deleteAllRecentCityes();
    emit(ExplorerIdle());
  }

  void retryCuisineSearch() {
    if (_lastCitySelected == null) return;
    selectCity(_lastCitySelected!);
  }

  void retryLastSearch() {
    if (_lastQuery == null) return;
    onSearchChanged(_lastQuery!);
  }

  void onSearchChanged(String text) {
    final query = text.trim();

    // Invalida tutte le request precedenti.
    _searchCancelToken?.cancel();

    if (query.length < 2) {
      _debouncer.cancel();
      emit(const ExplorerIdle());
      return;
    }

    _lastQuery = query;

    _debouncer(() async {
      emit(const ExplorerSearching());

      final cancelToken = CancelToken();
      _searchCancelToken = cancelToken;

      final result = await _repository.searchCities(
        query,
        "it",
        8,
        cancelToken: cancelToken,
      );

      if (cancelToken.isCancelled) return;

      switch (result) {
        case Success(:final value):
          if (value.isEmpty) {
            emit(const ExplorerNoResults());
          } else {
            emit(ExplorerSuggestionsLoaded(value));
          }

        case Failure(:final exception):
          emit(SearchCitiesError(exception.message));
      }
    });
  }

  Future<void> selectCity(CityModel city) async {
    // Cancella eventuali debounce in coda.
    _debouncer.cancel();
    _searchCancelToken?.cancel();

    emit(const ExplorerLoadingCuisines());

    _lastCitySelected = city;

    await _repository.saveRecentCity(city);

    final result = await _repository.getCuisines(
      city.latitude,
      city.longitude,
      "cuisine",
    );

    switch (result) {
      case Success(:final value):
        if (value.data.isEmpty) {
          emit(const ExplorerEmptyCuisines());
        } else {
          emit(ExplorerCuisinesLoaded(city, value));
        }

      case Failure(:final exception):
        emit(SearchCuisinesError(exception.message));
    }
  }

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }
}
