import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  String appLanguage;

  // Constructor with an optional initial language parameter
  AppProvider({this.appLanguage = 'en'}){
    initProvider();
  }

  Future<void>  initProvider() async {
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      appLanguage = prefs.getString('language')!;
      notifyListeners() ;

    }catch(e){
      print(e.toString());
    }
  }
  void changeLanguage(String newLanguage)async {
    if(appLanguage == newLanguage){
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language',newLanguage);
    appLanguage=newLanguage;
    notifyListeners();
  }
}
