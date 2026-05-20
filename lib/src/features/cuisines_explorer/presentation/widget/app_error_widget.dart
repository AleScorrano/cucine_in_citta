import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.onBack,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (onBack != null)
          Positioned(
            top: AppPadding.lg,
            left: AppPadding.lg,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primary,
                size: 32,
              ),
            ),
          ),

        Center(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.xxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_sharp,
                  size: 100,
                  color: AppColors.textSecondary,
                ),

                const SizedBox(height: AppPadding.lg),

                Text(
                  "Ops si è verificato un errore...",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppPadding.xl),

                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Riprova'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
