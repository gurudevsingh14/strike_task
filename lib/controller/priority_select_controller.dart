import 'package:flutter/material.dart';

class PrioritySelectController extends ChangeNotifier{
  int _selectedIndex=-1;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}