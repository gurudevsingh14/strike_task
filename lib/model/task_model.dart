import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:strike_task/model/priority.dart';

class TaskModel{
  String? id;
  String? name;
  String? category;
  String? description;
  DateTime? dueDate;
  String? priority;

  TaskModel({this.id, this.name, this.category, this.description, this.dueDate,
      this.priority});
}