import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';

class MyTheme{
  static final ThemeData myTheme=ThemeData(
    primaryColor: AppColors.primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.yellowColor,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.whiteColor),
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: AppColors.whiteColor,
        fontSize: 24,
      ),
      titleSmall: TextStyle(
        fontSize: 24, //widget.screenWidth * 0.05,
        // Adjust font size
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 24, //widget.screenWidth * 0.04,
        // Adjust font size
        color: AppColors.lightGrayColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 16, //widget.screenWidth * 0.04,
        // Adjust font size
        color: AppColors.lightGrayColor,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        color: AppColors.yellowColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.whiteColor,
      ),
    ),
  );
}