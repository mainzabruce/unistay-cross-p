import 'package:flutter/material.dart';
import 'package:unistay/core/constants/app_constants.dart';
import 'package:unistay/core/theme/app_text_styles.dart';

/// Application theme configuration
class AppTheme {
  AppTheme._();

  /// Light theme data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.surface,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.surface,
        outline: AppColors.border,
      ),
      fontFamily: 'Inter',
      textTheme: _buildTextTheme(),
      appBarTheme: _buildAppBarTheme(),
      cardTheme: _buildCardTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      textButtonTheme: _buildTextButtonTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      chipTheme: _buildChipTheme(),
      dividerTheme: _buildDividerTheme(),
      bottomNavigationBarTheme: _buildBottomNavTheme(),
      navigationBarTheme: _buildNavigationBarTheme(),
      floatingActionButtonTheme: _buildFabTheme(),
      dialogTheme: _buildDialogTheme(),
      snackBarTheme: _buildSnackBarTheme(),
      progressIndicatorTheme: _buildProgressTheme(),
      tabBarTheme: _buildTabBarTheme(),
      dropdownMenuTheme: _buildDropdownMenuTheme(),
    );
  }

  /// Dark theme data (future support)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: Color(0xFF1E1E1E),
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.surface,
        outline: Color(0xFF3A3A3A),
      ),
      fontFamily: 'Inter',
      textTheme: _buildTextTheme().apply(bodyColor: AppColors.textPrimary),
      appBarTheme: _buildAppBarTheme().copyWith(
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      cardTheme: _buildCardTheme().copyWith(
        color: const Color(0xFF1E1E1E),
      ),
      inputDecorationTheme: _buildInputDecorationTheme().copyWith(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: AppTextStyles.heading1,
      displayMedium: AppTextStyles.heading2,
      displaySmall: AppTextStyles.heading3,
      headlineLarge: AppTextStyles.heading2,
      headlineMedium: AppTextStyles.heading3,
      titleLarge: AppTextStyles.heading3,
      titleMedium: AppTextStyles.body,
      titleSmall: AppTextStyles.bodySmall,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.bodySmall,
      bodySmall: AppTextStyles.caption,
      labelLarge: AppTextStyles.button,
      labelMedium: AppTextStyles.label,
      labelSmall: AppTextStyles.captionSmall,
    );
  }

  static AppBarTheme _buildAppBarTheme() {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: AppElevation.xs,
      centerTitle: false,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: AppTextStyles.heading2,
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: AppComponentConstants.iconMedium,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: AppComponentConstants.iconMedium,
      ),
    );
  }

  static CardTheme _buildCardTheme() {
    return CardTheme(
      color: AppColors.surface,
      elevation: AppElevation.sm,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      margin: EdgeInsets.zero,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppElevation.none,
        minimumSize: const Size(AppComponentConstants.buttonMinWidth, AppComponentConstants.buttonHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.circular),
        ),
        textStyle: AppTextStyles.button.copyWith(letterSpacing: 0.5),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        disabledBackgroundColor: AppColors.textDisabled,
        disabledForegroundColor: AppColors.textHint,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(AppComponentConstants.buttonMinWidth, AppComponentConstants.buttonHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.circular),
        ),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        foregroundColor: AppColors.primary,
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(AppComponentConstants.buttonMinWidth, AppComponentConstants.buttonHeight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
        foregroundColor: AppColors.primary,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
      labelStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
      errorStyle: AppTextStyles.error,
      prefixIconColor: AppColors.textSecondary,
      suffixIconColor: AppColors.textSecondary,
    );
  }

  static ChipThemeData _buildChipTheme() {
    return ChipThemeData(
      backgroundColor: AppColors.surfaceVariant,
      selectedColor: AppColors.primaryLight.withOpacity(0.2),
      labelStyle: AppTextStyles.bodySmall,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.circular),
      ),
      side: BorderSide.none,
    );
  }

  static DividerThemeData _buildDividerTheme() {
    return const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: AppSpacing.md,
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavTheme() {
    return const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: AppElevation.lg,
    );
  }

  static NavigationBarThemeData _buildNavigationBarTheme() {
    return NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primary.withOpacity(0.1),
      labelTextStyle: WidgetStateProperty.resolveFrom((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTextStyles.label.copyWith(color: AppColors.primary);
        }
        return AppTextStyles.label;
      }),
      iconTheme: WidgetStateProperty.resolveFrom((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary);
        }
        return const IconThemeData(color: AppColors.textSecondary);
      }),
    );
  }

  static FloatingActionButtonThemeData _buildFabTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.surface,
      elevation: AppElevation.md,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    );
  }

  static DialogTheme _buildDialogTheme() {
    return DialogTheme(
      backgroundColor: AppColors.surface,
      elevation: AppElevation.lg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      titleTextStyle: AppTextStyles.heading3,
      contentTextStyle: AppTextStyles.body,
    );
  }

  static SnackBarThemeData _buildSnackBarTheme() {
    return SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: AppTextStyles.body.copyWith(color: AppColors.surface),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: AppElevation.lg,
    );
  }

  static ProgressIndicatorThemeData _buildProgressTheme() {
    return const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.surfaceVariant,
    );
  }

  static TabBarTheme _buildTabBarTheme() {
    return TabBarTheme(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: AppTextStyles.buttonSmall,
      unselectedLabelStyle: AppTextStyles.bodySmall,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  static DropdownMenuThemeData _buildDropdownMenuTheme() {
    return DropdownMenuThemeData(
      inputDecorationTheme: _buildInputDecorationTheme(),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.surface),
        elevation: WidgetStateProperty.all(AppElevation.lg),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        ),
      ),
    );
  }
}
