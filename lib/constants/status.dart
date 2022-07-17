import 'package:flutter/material.dart';
import '../model/status.dart';

List<Status>status=[
  Status(label: 'Pending',color: Colors.red,bgColor: Colors.red.withOpacity(0.3)),
  Status(label: 'In progress',color: Colors.yellow,bgColor: Colors.yellow.withOpacity(0.3)),
  Status(label: 'Done',color: Colors.green,bgColor: Colors.green.withOpacity(0.3))
];