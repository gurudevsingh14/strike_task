import 'package:flutter/material.dart';

class ConnectionController extends ChangeNotifier {
  bool _connection=true;

  bool get connection => _connection;

  set connection(bool value) {
    _connection = value;
    notifyListeners();
  }
}
