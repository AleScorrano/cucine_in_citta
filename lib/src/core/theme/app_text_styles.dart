import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const label = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}