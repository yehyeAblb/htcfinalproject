import 'package:flutter/material.dart';



class LanguageProvider extends ChangeNotifier{
  String language = 'er';
  void changeLanguage () {
   language = language =='en' ? 'ar' : 'en';
   notifyListeners();
  }
  /// 1 => light
  /// 0 => dark

}