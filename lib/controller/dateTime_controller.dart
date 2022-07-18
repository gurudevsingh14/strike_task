import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier{
  DateTime _selectedDate=DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }
}