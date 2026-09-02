import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

class AppTheme {
  AppTheme._();

  /* ================= DARK THEME ================= */

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,

    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,

    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      error: AppColors.error,
      surface: AppColors.cardDark,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.white,
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
      ),
      bodySmall: TextStyle(
        color: AppColors.textLight,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: AppColors.cardDark,
      elevation: 0,
    ),
  );

  /* ================= LIGHT THEME ================= */

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,

    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,

    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.card,
      foregroundColor: AppColors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      error: AppColors.error,
      surface: AppColors.card,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        color: AppColors.black,
      ),
      bodySmall: TextStyle(
        color: AppColors.textSecondary,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: AppColors.card,
      elevation: 0,
    ),
  );
}