import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_suggestion_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSearchWidget extends StatelessWidget {
  final List<CityModel> cities;
  const RecentSearchWidget({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CuisineExplorerCubit>();
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppPadding.md),
          Row(
            children: [
              Text(
                "Ricerche recenti",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(child: SizedBox()),
              TextButton(
                onPressed: cubit.deleteAllRecentCities,
                child: Text("Elimina"),
              ),
            ],
          ),
          const SizedBox(height: AppPadding.md),
          Flexible(
            child: CitySuggestionList(
              useCase: CitySuggestionListUseCase.showRecentSearch,
              cities: cities,
            ),
          ),
        ],
      ),
    );
  }
}
