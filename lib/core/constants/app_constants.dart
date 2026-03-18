// Design System Constants for UniStay

import 'package:flutter/material.dart';

/// Primary brand color - Green representing growth and trust
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF3A7D44);
  static const Color primaryLight = Color(0xFF5FA368);
  static const Color primaryDark = Color(0xFF2D5F35);

  // Secondary Colors
  static const Color secondary = Color(0xFFFFD166);
  static const Color secondaryLight = Color(0xFFFFE09A);
  static const Color secondaryDark = Color(0xFFE6B84D);

  // Neutral Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F4);

  // Text Colors
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textHint = Color(0xFFADB5BD);
  static const Color textDisabled = Color(0xFFDEE2E6);

  // Status Colors
  static const Color error = Color(0xFFEF476F);
  static const Color success = Color(0xFF06D6A0);
  static const Color warning = Color(0xFFFF9F1C);
  static const Color info = Color(0xFF4CC9F0);

  // Border & Divider
  static const Color border = Color(0xFFE9ECEF);
  static const Color divider = Color(0xFFDEE2E6);

  // Shadow
  static const Color shadow = Color(0x1A000000);
}

/// Spacing system based on 4px grid
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  /// Common spacing combinations
  static EdgeInsets horizontalPadding = const EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
  );
  
  static EdgeInsets verticalPadding = const EdgeInsets.symmetric(
    vertical: AppSpacing.md,
  );

  static EdgeInsets screenPadding = const EdgeInsets.all(AppSpacing.md);
}

/// Border radius system
class AppRadius {
  AppRadius._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double circular = 9999.0;
}

/// Elevation/Shadow system
class AppElevation {
  AppElevation._();

  static const double none = 0.0;
  static const double xs = 1.0;
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;
  static const double xl = 16.0;

  static List<BoxShadow> get sm => [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get md => [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get lg => [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];
}

/// Duration constants for animations
class AppDuration {
  AppDuration._();

  static const Duration instant = Duration.zero;
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 450);
  static const Duration slower = Duration(milliseconds: 600);
}

/// Component-specific constants
class AppComponentConstants {
  AppComponentConstants._();

  // Button
  static const double buttonHeight = 44.0;
  static const double buttonMinWidth = 120.0;
  static const double buttonIconSize = 20.0;

  // Input
  static const double inputHeight = 48.0;
  static const double inputBorderRadius = AppRadius.sm;
  static const double inputPadding = AppSpacing.sm;

  // Card
  static const double cardBorderRadius = AppRadius.sm;
  static const double cardElevation = AppElevation.sm;
  static const double cardPadding = AppSpacing.md;

  // Image
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 48.0;
  static const double avatarLarge = 64.0;
  static const double thumbnailSmall = 80.0;
  static const double thumbnailMedium = 120.0;
  static const double thumbnailLarge = 200.0;

  // Icon
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
}
