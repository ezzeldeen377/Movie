import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie/core/theme/app_colors.dart';

class MyTheme {
  static final ThemeData myTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.yellowColor,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.whiteColor,
    ),
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
        fontSize: 24.h,
      ),
      titleSmall: TextStyle(
        fontSize: 24.h,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.h,
        color: AppColors.lightGrayColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 16.h,
        color: AppColors.lightGrayColor,
      ),
      bodySmall: TextStyle(
        fontSize: 18.h,
        color: AppColors.yellowColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.h,
        color: AppColors.whiteColor,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
      ),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.yellowColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.yellowColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGrayColor,
            width: 1.h,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGrayColor,
            width: 1.h,
          ),
        ),
      ),
    ),
  );
}
