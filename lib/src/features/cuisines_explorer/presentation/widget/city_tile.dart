import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityTile extends StatelessWidget {
  const CityTile({
    super.key,
    required this.city,
    required this.onTap,
    this.onDelete,
  });

  final CityModel city;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppPadding.lg,
        vertical: AppPadding.sm,
      ),

      leading: onDelete != null
          ? IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: onDelete,
              icon: Icon(
                CupertinoIcons.xmark,
                color: AppColors.primary,
                size: 20,
              ),
            )
          : null,

      title: Text(
        city.name,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: AppPadding.xs),
        child: Text(
          city.description,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),

      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
        size: 28,
      ),
    );
  }
}
