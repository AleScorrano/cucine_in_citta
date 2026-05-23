import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/di/cuisine_explorer_providers.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitySuggestionList extends ConsumerWidget {
  final List<CityModel> cities;
  const CitySuggestionList({super.key, required this.cities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(cuisineExplorerViewModelProvider.notifier);
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
              viewModel.selectCity(city);
            },
          );
        },
      ),
    );
  }
}
