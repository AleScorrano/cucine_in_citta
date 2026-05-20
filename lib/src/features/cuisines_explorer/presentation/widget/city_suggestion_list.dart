import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitySuggestionList extends StatelessWidget {
  final List<CityModel> cities;
  const CitySuggestionList({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CuisineExplorerCubit>();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: ListView.separated(
        itemCount: cities.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: AppColors.border),
        itemBuilder: (_, index) {
          final city = cities[index];
          return CityTile(
            city: city,
            onTap: () {
              cubit.selectCity(city);
            },
          );
        },
      ),
    );
  }
}
