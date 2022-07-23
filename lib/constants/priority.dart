import 'package:flutter/material.dart';

import '../model/priority.dart';

Map<String,PriorityModel>priorityList= {
  'high': PriorityModel(label: "High", bgColor: Colors.red.shade50, color: Colors.red),
  'medium':PriorityModel(label: "Medium", bgColor: Colors.orange.shade50, color: Colors.deepOrangeAccent),
  'low':PriorityModel(
      label: "Low", bgColor: Colors.green.shade50, color: Colors.green),
};