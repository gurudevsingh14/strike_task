import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarController extends ChangeNotifier{
  DateTime? _selectedDay=DateTime.now();

  DateTime get selectedDay => _selectedDay!;

  set selectedDay(DateTime value) {
    _selectedDay = value;
    notifyListeners();
  }

  DateTime? _focusedDay=DateTime.now();

  DateTime get focusedDay => _focusedDay!;

  set focusedDay(DateTime value) {
    _focusedDay = value;
    notifyListeners();
  }

  CalendarFormat _calendarFormat=CalendarFormat.month;

  CalendarFormat get calendarFormat => _calendarFormat;

  set calendarFormat(CalendarFormat value) {
    _calendarFormat = value;
  }
}