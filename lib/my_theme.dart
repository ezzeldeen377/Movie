import 'package:flutter/material.dart';
import 'package:movie/app_colors.dart';

class MyTheme{
  static final ThemeData myTheme=ThemeData(
    primaryColor: AppColors.primaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.yellowColor,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.whiteColor



    )
  );
}