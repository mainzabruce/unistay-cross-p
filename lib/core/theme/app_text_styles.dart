import 'package:flutter/material.dart';
import 'package:unistay/core/constants/app_constants.dart';

/// Text style system using Inter font family
class AppTextStyles {
  AppTextStyles._();

  // Base style
  static const TextStyle _baseStyle = TextStyle(
    fontFamily: 'Inter',
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: -0.3,
  );

  /// Heading 1 - 28px SemiBold
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  /// Heading 2 - 24px SemiBold
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.3,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  /// Heading 3 - 20px Medium
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  /// Body - 16px Regular
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  /// Body Small - 14px Regular
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  /// Caption - 14px Regular (secondary text)
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
  );

  /// Caption Small - 12px Regular
  static const TextStyle captionSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
  );

  /// Button - 16px Medium uppercase
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
    color: AppColors.surface,
    fontFamily: 'Inter',
  );

  /// Button Small - 14px Medium uppercase
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.3,
    color: AppColors.surface,
    fontFamily: 'Inter',
  );

  /// Label - 12px Medium
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.2,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
  );

  /// Overline - 10px Medium uppercase
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: 1.0,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
  );

  /// Price/Amount style
  static const TextStyle price = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.primary,
    fontFamily: 'Inter',
  );

  /// Price Large style
  static const TextStyle priceLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.primary,
    fontFamily: 'Inter',
  );

  /// Link style
  static const TextStyle link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.primary,
    fontFamily: 'Inter',
    decoration: TextDecoration.none,
  );

  /// Error text style
  static const TextStyle error = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.error,
    fontFamily: 'Inter',
  );

  /// Success text style
  static const TextStyle success = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.success,
    fontFamily: 'Inter',
  );

  /// Helper method to create variant styles
  static TextStyle withColor(TextStyle base, Color color) {
    return base.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle base, FontWeight weight) {
    return base.copyWith(fontWeight: weight);
  }

  static TextStyle withSize(TextStyle base, double size) {
    return base.copyWith(fontSize: size);
  }
}
