import 'package:flutter/material.dart';

/// Simple color palette - just define your colors and use them
class AppColors {
  // Brand colors
  static const primary = Color(0xFF0C69D3);
  static const primaryBright = Color(0xFF137FF5);
  static const success = Color(0xFF00C853);
  static const error = Color(0xFFFF5252);
  
  // Background colors
  static const background = Color(0xFF141518);
  static const surface = Color(0xFF1E1E20);
  static const surfaceBright = Color(0xFF252534);
  
  // Text colors
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB3B3B3);
  
  // UI element colors
  static const errorContainer = Color(0x1AFF5252);
  static const errorBorder = Color(0x3DFF5252);
  static const errorText = Color(0xFFFF5252);
  static const mutedBorder = Color(0x1EFFFFFF);
  static const inputIcon = Color(0xB3FFFFFF);
  static const inputBorder = Color(0x1F141518);
  static const disabled = Color(0x66FFFFFF);
  static const disabledBackground = Color(0xFF1F1F1F);
  static const disabledForeground = Color(0xFF6B7280);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.textPrimary,
        surface: AppColors.background,
        onSurface: AppColors.textPrimary,
        surfaceContainer: AppColors.surface,
        surfaceBright: AppColors.surfaceBright,
        error: AppColors.error,
        onError: AppColors.textPrimary,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        labelLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.background),
      dividerTheme: const DividerThemeData(color: AppColors.background, thickness: 1),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.background,
        contentTextStyle: TextStyle(color: AppColors.textPrimary),
        actionTextColor: AppColors.primary,
      ),
    );
  }
}


