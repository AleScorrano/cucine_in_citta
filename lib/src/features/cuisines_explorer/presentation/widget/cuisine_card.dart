import 'package:cached_network_image/cached_network_image.dart';
import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/cuisine_model.dart';
import 'package:flutter/material.dart';

class CuisineCard extends StatelessWidget {
  const CuisineCard({super.key, required this.cuisine});

  final CuisineModel cuisine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.md),
      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: CachedNetworkImage(imageUrl: cuisine.emoji)),
          Text(
            cuisine.nameIt,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
