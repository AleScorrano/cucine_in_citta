import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        AppColors.background,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),

    textTheme: TextTheme(
      // HERO TITLE
      displayLarge:
          GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1,
      ),

      // PAGE TITLE
      displayMedium:
          GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1,
      ),

      // CARD TITLE
      titleLarge:
          GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),

      // SUBTITLE
      bodyLarge:
          GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),

      // NORMAL TEXT
      bodyMedium:
          GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),

      // SMALL LABEL
      bodySmall:
          GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
    ),

    inputDecorationTheme:
        InputDecorationTheme(
      filled: true,

      fillColor: AppColors.surface,

      hintStyle:
          GoogleFonts.inter(
        color: AppColors.textSecondary,
        fontSize: 18,
      ),

      contentPadding:
          const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),

      prefixIconColor:
          AppColors.primary,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          40,
        ),

        borderSide:
            const BorderSide(
          color: AppColors.border,
        ),
      ),

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          40,
        ),

        borderSide:
            const BorderSide(
          color: AppColors.border,
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          40,
        ),

        borderSide:
            const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    ),
  );
}