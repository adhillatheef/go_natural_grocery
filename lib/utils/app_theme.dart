import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.cardBackground, // Using card color as base for login background if needed, or set to white
      fontFamily: AppTypography.fontFamily,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        error: AppColors.error,
      ),

      // AppBar global styling
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textMain),
        titleTextStyle: AppTypography.h2,
        centerTitle: true,
      ),

      // Global Elevated Button Styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTypography.buttonText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Adjust based on Figma
          ),
          minimumSize: const Size(double.infinity, 50),
          elevation: 0,
        ),
      ),

      // Global Text Field Styling (perfect for the Login screen)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.textDisabled),
      ),

      // Global Bottom Navigation Bar Styling
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textDisabled,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontFamily: AppTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}