import 'package:flutter/material.dart';

class PrioritySelectController extends ChangeNotifier{
  String? _selectedPriority;

  String? get selectedPriority => _selectedPriority;

  set selectedPriority(String? value) {
    _selectedPriority = value;
    notifyListeners();
  }
}