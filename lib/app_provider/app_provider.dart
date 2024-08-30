import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String appLanguage;

  // Constructor with an optional initial language parameter
  AppProvider({this.appLanguage = 'ar'});

  void changeLanguage(String newLanguage) {
    if (newLanguage == appLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
