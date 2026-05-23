import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_response_model.dart';
import '../../data/models/city_model.dart';

sealed class CuisineExplorerState {
  const CuisineExplorerState();
}

class ExplorerIdle extends CuisineExplorerState {
  const ExplorerIdle();
}

class ExplorerSearching extends CuisineExplorerState {
  const ExplorerSearching();
}

class ExplorerSuggestionsLoaded extends CuisineExplorerState {
  final List<CityModel> cities;

  const ExplorerSuggestionsLoaded(this.cities);
}

class ExplorerNoResults extends CuisineExplorerState {
  const ExplorerNoResults();
}

class ExplorerLoadingCuisines extends CuisineExplorerState {
  const ExplorerLoadingCuisines();
}

class ExplorerCuisinesLoaded extends CuisineExplorerState {
  final CityModel city;
  final CuisineResponseModel cuisines;

  const ExplorerCuisinesLoaded(this.city, this.cuisines);
}

class ExplorerEmptyCuisines extends CuisineExplorerState {
  const ExplorerEmptyCuisines();
}

class SearchCitiesError extends CuisineExplorerState {
  final String message;

  const SearchCitiesError(this.message);
}

class SearchCuisinesError extends CuisineExplorerState {
  final String message;

  const SearchCuisinesError(this.message);
}
