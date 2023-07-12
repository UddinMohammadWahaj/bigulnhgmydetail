import 'package:bigul_ekyc/utils/AppColors.dart';
import 'package:bigul_ekyc/utils/MyTextTheme.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  // Light mode colors

  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.lightScaffoldBackground,
  cardColor: AppColors.lightCardColor,
  hintColor: AppColors.lightHintColor,
  textTheme: MyTextTheme.light,
  dividerColor: Colors.grey,
  secondaryHeaderColor: AppColors.lightSecondaryTextColor
    ,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor:  AppColors.primary
),
);

final darkTheme = ThemeData.dark().copyWith(
  // Dark mode colors
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
  cardColor: AppColors.darkCardColor,
  hintColor: AppColors.darkHintColor,
  textTheme: MyTextTheme.dark,
  dividerColor: AppColors.darkTextColor,
  secondaryHeaderColor: AppColors.darkSecondaryTextColor,
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor:  AppColors.primary
  ),
);
