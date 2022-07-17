import 'package:flutter/material.dart';

class ScreenController extends ChangeNotifier{
  int _currScreen=0;

  int get currScreen => _currScreen;

  set currScreen(int value) {
    _currScreen = value;
    notifyListeners();
  }
}
