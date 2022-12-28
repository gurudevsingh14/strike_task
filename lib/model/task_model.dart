import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:strike_task/model/priority.dart';
import 'package:strike_task/model/sub_task_model.dart';

import 'categories.dart';

class Task{
  String? id;
  String? name;
  TaskCategory category;
  String? description;
  DateTime? dueDate;
  String? priority;
  int subTaskDoneCount;
  List<SubTask>? subTaskList=[];


  Task({this.id, this.name,required this.category, this.description, this.dueDate,
      this.priority, this.subTaskList, this.subTaskDoneCount=0});

  factory Task.fromJson(Map<String, dynamic> data) {
    return Task(
        id: data['id'],
        name: data['name'],
        category: data['category'],
        description: data['description'],
        dueDate: data['dueDate'],
        priority: data['priority'],
        subTaskList: data['subTaskList'],
        subTaskDoneCount: data['subTaskDoneCount']
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'subTaskList': subTaskList,
      'subTaskDoneCount': subTaskDoneCount
    };
  }
}