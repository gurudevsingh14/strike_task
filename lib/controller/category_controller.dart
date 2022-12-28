import 'package:flutter/material.dart';
import 'package:strike_task/model/categories.dart';

import '../constants/category_list.dart';

class CategoryController extends ChangeNotifier{
  String? _selectedCategory;

  String? get selectedCategory => _selectedCategory;

  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }
  void addcategory(TaskCategory value){
    categoryList.add(value);
    notifyListeners();
  }
}