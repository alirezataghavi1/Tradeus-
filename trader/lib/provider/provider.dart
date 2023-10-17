import 'package:flutter/material.dart';



class ProviderLoc extends ChangeNotifier{
 Locale _locale = Locale('en');
Locale get locale=> _locale;
void setLocale (Locale locale){
  _locale = locale;
  notifyListeners();
}
  
}