import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/di/cuisine_explorer_providers.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/viewModels/cuisine_explorer_state.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_list_skeleton.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_suggestion_list.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/idle_widget.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/search_bar.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitySearchView extends ConsumerWidget {
  const CitySearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(cuisineExplorerViewModelProvider.notifier);

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
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.md),
            child: CitySearchBar(onChanged: viewModel.onSearchChanged),
          ),

          const SizedBox(height: AppPadding.lg),

          Expanded(child: _buildBody(context, ref)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cuisineExplorerViewModelProvider);
    final viewModel = ref.read(cuisineExplorerViewModelProvider.notifier);

    return switch (state) {
      ExplorerIdle() => const IdleWidget(),
      ExplorerSearching() => const CityListSkeleton(),
      ExplorerNoResults() => _noResultsWidget(context),
      SearchCitiesError(:final message) => AppErrorWidget(
        message: message,
        onRetry: viewModel.retryLastSearch,
      ),

      ExplorerSuggestionsLoaded(:final cities) => CitySuggestionList(
        cities: cities,
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
