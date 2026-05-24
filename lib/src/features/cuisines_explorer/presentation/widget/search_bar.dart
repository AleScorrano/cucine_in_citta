import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';

class CitySearchBar extends StatelessWidget {
  const CitySearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final double borderRadius = 24;
    return TextField(
      onChanged: onChanged,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Cerca una città...',
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.xl),
          child: Icon(Icons.search, color: AppColors.primary, size: 32),
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppPadding.lg + AppPadding.xs,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.primary),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
