import 'package:cucine_in_citta/src/features/cuisines_explorer/data/datasource/cuisines_explorer_remote_datasource.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../shared/result.dart';
import '../../data/models/city_model.dart';

class CuisineExplorerCubit extends Cubit<CuisineExplorerState> {
  CuisineExplorerCubit(this._dataSource) : super(const ExplorerIdle());

  final CuisineExplorerRemoteDatasource _dataSource;

  /// Debounce per evitare chiamate API
  /// ad ogni keystroke.
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  String? _lastQuery;
  CityModel? _lastCitySelected;

  /// Identifica l’ultima request valida
  /// per evitare race conditions.
  int _activeRequestId = 0;

  void resetState() {
    emit(const ExplorerIdle());
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
    final requestId = ++_activeRequestId;

    if (query.length < 2) {
      emit(const ExplorerIdle());
      return;
    }

    _lastQuery = query;

    _debouncer(() async {
      // Ignora debounce non più validi.
      if (requestId != _activeRequestId) {
        return;
      }

      emit(const ExplorerSearching());

      final result = await _dataSource.searchCities(query, "it", 8);

      // Ignora response obsolete.
      if (requestId != _activeRequestId) {
        return;
      }

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
    // Invalida tutte le search pendenti.
    _activeRequestId++;

    // Cancella eventuali debounce in coda.
    _debouncer.cancel();

    emit(const ExplorerLoadingCuisines());

    _lastCitySelected = city;

    final result = await _dataSource.getCuisines(
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
