import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CityListSkeleton
    extends StatelessWidget {

  const CityListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius:
              BorderRadius.circular(
            24,
          ),
        ),

        child: ListView.builder(
          itemCount: 4,

          itemBuilder:
              (_, index) {
            return const ListTile(
              title: Text(
                '------------',
              ),

              subtitle: Text(
                '----------------------',
              ),

              trailing: Icon(
                Icons.chevron_right,
              ),
            );
          },
        ),
      ),
    );
  }
}