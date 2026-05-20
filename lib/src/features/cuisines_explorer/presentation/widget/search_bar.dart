import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';

class CitySearchBar extends StatelessWidget {
  const CitySearchBar({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
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
        contentPadding: EdgeInsets.symmetric(vertical: AppPadding.xl),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
