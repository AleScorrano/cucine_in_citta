import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CuisinesLoadingView extends StatelessWidget {
  const CuisinesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Skeletonizer(
        enabled: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppPadding.sm),
            Text("--------------"),
            const SizedBox(height: AppPadding.sm),
            Text("----------------------"),
            const SizedBox(height: AppPadding.xxl),
            Text('-------------------------------'),

            const SizedBox(height: AppPadding.xl),
            Expanded(
              child: GridView.builder(
                itemCount: 22,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: AppPadding.lg,
                  mainAxisSpacing: AppPadding.lg,
                ),

                itemBuilder: (_, __) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
