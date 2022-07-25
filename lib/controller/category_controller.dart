import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier{
  String _selectedCategory='home';

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }
}