import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_state.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_list_skeleton.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_suggestion_list.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/idle_widget.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/recent_search_widget.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/search_bar.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySearchView extends StatelessWidget {
  const CitySearchView({super.key, required this.state});

  final CuisineExplorerState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CuisineExplorerCubit>();

    return Padding(
      padding: const EdgeInsets.all(AppPadding.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppPadding.lg),
          Center(
            child: Text(
              'Cucine in città',
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontSize: 36),
            ),
          ),

          const SizedBox(height: AppPadding.xl + AppPadding.lg),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.xs),
            child: CitySearchBar(onChanged: cubit.onSearchChanged),
          ),

          const SizedBox(height: AppPadding.lg),

          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final cubit = context.read<CuisineExplorerCubit>();

    final List<CityModel> recentSearch = cubit.getRecentCities();

    return switch (state) {
      ExplorerIdle() =>
        recentSearch.isEmpty
            ? IdleWidget()
            : RecentSearchWidget(cities: recentSearch),
      ExplorerSearching() => const CityListSkeleton(),
      ExplorerNoResults() => _noResultsWidget(context),
      SearchCitiesError(:final message) => AppErrorWidget(
        message: message,
        onRetry: () => cubit.retryLastSearch(),
      ),
      ExplorerSuggestionsLoaded(:final cities) => Flexible(
        child: CitySuggestionList(
          useCase: CitySuggestionListUseCase.showSuggestion,
          cities: cities,
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _noResultsWidget(BuildContext context) => Center(
    child: Text(
      'Nessun risultato',
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );
}
