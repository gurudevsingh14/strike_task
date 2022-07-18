import 'package:flutter/material.dart';

class TextFieldController extends ChangeNotifier{
  Color _bgColor=Colors.transparent;

  Color get bgColor => _bgColor;

  set bgColor(Color value) {
    _bgColor = value;
    notifyListeners();
  }
}