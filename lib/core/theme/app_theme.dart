import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color success;
  final Color primaryBright;
  final Color errorContainer; // background for error messages
  final Color errorBorder; // border color for error boxes
  final Color errorText; // primary text color for error messages
  final Color disabledBackground;
  final Color disabledForeground;
  final Color inputIcon;
  final Color mutedBorder;
  final Color inputBorder;

  const AppColors({
    required this.success,
    required this.primaryBright,
    required this.errorContainer,
    required this.errorBorder,
    required this.errorText,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.inputIcon,
    required this.mutedBorder,
    required this.inputBorder,
  });

  @override
  AppColors copyWith({
    Color? success,
    Color? primaryBright,
    Color? errorContainer,
    Color? errorBorder,
    Color? errorText,
    Color? disabledBackground,
    Color? disabledForeground,
    Color? inputIcon,
    Color? mutedBorder,
    Color? inputBorder,
  }) =>
    AppColors(
      success: success ?? this.success,
      primaryBright: primaryBright ?? this.primaryBright,
      errorContainer: errorContainer ?? this.errorContainer,
      errorBorder: errorBorder ?? this.errorBorder,
      errorText: errorText ?? this.errorText,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      inputIcon: inputIcon ?? this.inputIcon,
      mutedBorder: mutedBorder ?? this.mutedBorder,
      inputBorder: inputBorder ?? this.inputBorder,
    );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      primaryBright: Color.lerp(primaryBright, other.primaryBright, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      errorBorder: Color.lerp(errorBorder, other.errorBorder, t)!,
      errorText: Color.lerp(errorText, other.errorText, t)!,
      disabledBackground: Color.lerp(disabledBackground, other.disabledBackground, t)!,
      disabledForeground: Color.lerp(disabledForeground, other.disabledForeground, t)!,
      inputIcon: Color.lerp(inputIcon, other.inputIcon, t)!,
      mutedBorder: Color.lerp(mutedBorder, other.mutedBorder, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
    );
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    final base = ThemeData.dark();

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF141518),
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF0C69D3),
        onPrimary: const Color(0xFFFFFFFF),
        surface: const Color(0xFF141518),
        onSurface: const Color(0xFFFFFFFF),
        surfaceContainer: const Color(0xFF1E1E20),
        surfaceBright: const Color(0xFF252534),
        error: const Color(0xFFFF5252),
        onError: const Color(0xFFFFFFFF),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFB3B3B3),
          fontSize: 14,
        ),
        labelLarge: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF141518)),
      dividerTheme: const DividerThemeData(color: Color(0xFF141518), thickness: 1),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF141518),
        contentTextStyle: TextStyle(color: Color(0xFFFFFFFF)),
        actionTextColor: Color(0xFF0c69d3),
      ),
      // use runtime-derived theme extensions so semitransparent variants
      // derive from the active colorScheme and stay consistent
      extensions: <ThemeExtension<dynamic>>[
        AppColors(
          success: const Color(0xFF00C853),
          primaryBright: const Color(0xFF137FF5),
          // derive alpha variants from the colorScheme so changing the
          // scheme updates these automatically
          errorContainer: base.colorScheme.error.withAlpha((0.10 * 255).round()),
          errorBorder: base.colorScheme.error.withAlpha((0.24 * 255).round()),
          mutedBorder: base.colorScheme.onSurface.withAlpha((0.12 * 255).round()),
          errorText: base.colorScheme.error,
          disabledBackground: base.colorScheme.surface.withAlpha((0.12 * 255).round()),
          disabledForeground: base.colorScheme.onSurface.withAlpha((0.40 * 255).round()),
          inputIcon: base.colorScheme.onSurface.withAlpha((0.70 * 255).round()),
          inputBorder: base.colorScheme.onSurface.withAlpha(0x14),
        ),
        AppTextStyles(
          errorBody: TextStyle(
            color: base.colorScheme.error,
            fontSize: 14,
          ),
          inputLabel: TextStyle(
            color: base.colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          inputHint: TextStyle(
            color: base.colorScheme.onSurface.withAlpha((0.70 * 255).round()),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// Build a ThemeData from an explicit palette provided by the developer.
  /// This will not auto-generate tonal palettes; it uses only the colors you
  /// pass in the [CustomPalette]. The idea is to give you 100% control.
  static ThemeData customFromPalette(CustomPalette p, {bool useMaterial3 = false}) {
    final fcs = FlexColorScheme.dark(
      colors: FlexSchemeColor(
        primary: p.primary,
        primaryContainer: p.primaryContainer,
        secondary: p.secondary,
        secondaryContainer: p.secondaryContainer,
        tertiary: p.tertiary,
        tertiaryContainer: p.tertiaryContainer,
        appBarColor: p.appBar,
        error: p.error,
      ),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      // Ensure we don't apply any automatic surface blends or tonal generation
      blendLevel: 0,
      useMaterial3: useMaterial3,
      subThemesData: const FlexSubThemesData(useTextTheme: true),
    );

    final theme = fcs.toTheme.copyWith(
      scaffoldBackgroundColor: p.scaffoldBackground,
      appBarTheme: AppBarTheme(backgroundColor: p.appBar),
      textTheme: fcs.toTheme.textTheme,
      extensions: <ThemeExtension<dynamic>>[
        AppColors(
          success: p.success,
          primaryBright: p.primaryBright,
          errorContainer: p.errorContainer,
          errorBorder: p.errorBorder,
          mutedBorder: p.mutedBorder,
          errorText: p.error,
          disabledBackground: p.disabledBackground,
          disabledForeground: p.disabledForeground,
          inputIcon: p.inputIcon,
          inputBorder: p.inputBorder,
        ),
        AppTextStyles(
          errorBody: TextStyle(color: p.error),
          inputLabel: TextStyle(color: p.onSurface, fontSize: 16, fontWeight: FontWeight.w500),
          inputHint: TextStyle(color: p.onSurface.withAlpha((0.7 * 255).round()), fontSize: 14),
        ),
      ],
    );

    return theme;
  }
}

/// Small struct to pass explicit colors for a custom theme.
class CustomPalette {
  final Color primary;
  final Color primaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color tertiary;
  final Color tertiaryContainer;
  final Color scaffoldBackground;
  final Color appBar;
  final Color onSurface;
  final Color error;
  final Color success;
  final Color primaryBright;
  final Color errorContainer;
  final Color errorBorder;
  final Color mutedBorder;
  final Color disabledBackground;
  final Color disabledForeground;
  final Color inputIcon;
  final Color inputBorder;

  const CustomPalette({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.tertiary,
    required this.tertiaryContainer,
    required this.scaffoldBackground,
    required this.appBar,
    required this.onSurface,
    required this.error,
    required this.success,
    required this.primaryBright,
    required this.errorContainer,
    required this.errorBorder,
    required this.mutedBorder,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.inputIcon,
    required this.inputBorder,
  });
}

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle errorBody;
  final TextStyle inputLabel;
  final TextStyle inputHint;

  const AppTextStyles({required this.errorBody, required this.inputLabel, required this.inputHint});

  @override
  AppTextStyles copyWith({TextStyle? errorBody, TextStyle? inputLabel, TextStyle? inputHint}) =>
      AppTextStyles(
        errorBody: errorBody ?? this.errorBody,
        inputLabel: inputLabel ?? this.inputLabel,
        inputHint: inputHint ?? this.inputHint,
      );

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      errorBody: TextStyle.lerp(errorBody, other.errorBody, t)!,
      inputLabel: TextStyle.lerp(inputLabel, other.inputLabel, t)!,
      inputHint: TextStyle.lerp(inputHint, other.inputHint, t)!,
    );
  }
}
