import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_state.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/city_search_view.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/cuisine_loading_view.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/screens/cuisine_view.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/empty_cousines_widget.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CuisineExplorerPage extends StatelessWidget {
  const CuisineExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CuisineExplorerCubit>();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CuisineExplorerCubit, CuisineExplorerState>(
          builder: (context, state) {
            return AnimatedSwitcher(
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
                  onRetry: () => cubit.retryCuisineSearch(),
                  onBack: () => cubit.resetState(),
                ),

                _ => CitySearchView(state: state),
              },
            );
          },
        ),
      ),
    );
  }
}
