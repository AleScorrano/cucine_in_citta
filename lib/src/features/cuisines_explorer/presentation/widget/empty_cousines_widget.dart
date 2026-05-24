import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyCousinesWidget extends StatelessWidget {
  const EmptyCousinesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                context.read<CuisineExplorerCubit>().resetState();
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
      ),
    );
  }
}
