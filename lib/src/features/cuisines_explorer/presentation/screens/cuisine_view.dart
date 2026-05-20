import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_response_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/cuisine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CuisinesView extends StatelessWidget {
  const CuisinesView({super.key, required this.city, required this.cuisines});

  final CuisineResponseModel cuisines;
  final CityModel city;

  @override
  Widget build(BuildContext context) {
    return Padding(
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

          const SizedBox(height: AppPadding.xl),

          Text(
            city.name,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),

          const SizedBox(height: AppPadding.sm),

          Text(
            city.structuredFormatting.secondary_text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: AppPadding.xxl),

          Text(
            '${cuisines.length} cucine disponibili',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: AppPadding.lg),

          Expanded(
            child: GridView.builder(
              itemCount: cuisines.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.80,
              ),

              itemBuilder: (_, index) {
                final cuisine = cuisines.data[index];

                return CuisineCard(cuisine: cuisine);
              },
            ),
          ),
        ],
      ),
    );
  }
}
