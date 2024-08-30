import 'package:flutter/material.dart';

class ProviderLanguages extends ChangeNotifier{
  String Applan='en';
  void changeLan(String newLan){
if(Applan==newLan){


  return;
}
Applan=newLan;
notifyListeners();


  }





}