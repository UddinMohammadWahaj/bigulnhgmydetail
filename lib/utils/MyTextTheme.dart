import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:flutter/material.dart';

class MyTextTheme {
  static const TextTheme light = TextTheme(
    displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextColor),
    displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextColor),
    displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightTextColor),
  );

  static const TextTheme dark = TextTheme(
    displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextColor),
    displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextColor),
    displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: AppColors.darkTextColor),
  );
}
