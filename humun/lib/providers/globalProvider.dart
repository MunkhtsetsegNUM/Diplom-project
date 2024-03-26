import 'package:flutter/material.dart';

// ignore: camel_case_types
class Global_provider extends ChangeNotifier{
  int currentIdx=0;

  void changeCurrentIdx(int idx){
    currentIdx=idx;
    notifyListeners();
  }

}