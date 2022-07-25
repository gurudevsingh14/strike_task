import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:strike_task/model/priority.dart';
import 'package:strike_task/model/sub_task_model.dart';

class TaskModel{
  String? id;
  String? name;
  String? category;
  String? description;
  DateTime? dueDate;
  String? priority;
  List<SubTask> subTaskList=[];

  TaskModel({this.id, this.name, this.category, this.description, this.dueDate,
      this.priority});
}