import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const String fontFamily = 'Lufga';

  // Headings (e.g., "Login", Product Titles on detail page)
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textMain,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain,
  );

  // Body text (e.g., descriptions, input fields)
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textMain,
  );

  // Small text (e.g., old price strike-through, disabled states)
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
  );

  // Button text
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}