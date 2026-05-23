import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/di/cuisine_explorer_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptyCousinesWidget extends ConsumerWidget {
  const EmptyCousinesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(cuisineExplorerViewModelProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              viewModel.resetState();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          Expanded(child: SizedBox()),
          Center(
            child: Icon(
              Icons.food_bank_sharp,
              size: 100,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppPadding.lg),
          Center(
            child: Text(
              "Nessuna cucina disponibile..",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
