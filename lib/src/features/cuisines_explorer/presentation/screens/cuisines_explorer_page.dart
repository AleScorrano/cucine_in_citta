import 'package:cucine_in_citta/src/features/cuisines_explorer/di/cuisine_explorer_providers.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/city_search_view.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/cuisine_loading_view.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/cuisine_view.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/viewModels/cuisine_explorer_state.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/empty_cousines_widget.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CuisineExplorerPage extends ConsumerWidget {
  const CuisineExplorerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cuisineExplorerViewModelProvider);
    final viewModel = ref.read(cuisineExplorerViewModelProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: switch (state) {
            ExplorerEmptyCuisines() => const EmptyCousinesWidget(),
            ExplorerLoadingCuisines() => const CuisinesLoadingView(),
            ExplorerCuisinesLoaded() => CuisinesView(
              city: state.city,
              cuisines: state.cuisines,
            ),
            SearchCuisinesError(:final message) => AppErrorWidget(
              message: message,
              onRetry: () => viewModel.retryCuisineSearch(),
            ),

            _ => CitySearchView(),
          },
        ),
      ),
    );
  }
}
