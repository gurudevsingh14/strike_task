import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:strike_task/model/priority.dart';
import 'package:strike_task/model/sub_task_model.dart';


class Task{
  String? id;
  String? name;
  String? category;
  String? description;
  DateTime? dueDate;
  String? priority;
  bool? isArchived;
  bool? markedCompleted;
  List<SubTask>? subTaskList=[];
  bool? isStarred;
  Task({this.id, this.name,this.category, this.description, this.dueDate,
      this.priority,this.isArchived=false,this.isStarred=false,this.markedCompleted=false});

  bool isSubTasksCompleted(){
    int count=0;
    if(subTaskList==null||subTaskList!.length==0) return false;
    subTaskList!.forEach((ele) {
      if(ele.done)count++;
    });
    return subTaskList!.length==count;
  }
  bool isTaskCompleted(){
    if(markedCompleted==true) return true;
    return isSubTasksCompleted();
  }
  double completePercentage(){
    int count=0;
    if(subTaskList==null||subTaskList!.length==0) return 0.0;
    subTaskList!.forEach((ele) {
      if(ele.done)count++;
    });
    return (count/subTaskList!.length)*100;
  }
  factory Task.fromJson(Map<String, dynamic> data) {
    return Task(
        id: data['id'],
        name: data['name'],
        category: data['category'],
        description: data['description'],
        dueDate: DateTime.parse(data['dueDate']),
        priority: data['priority'],
        isArchived: data['isArchived'],
        isStarred: data['isStarred'],
        markedCompleted: data['markedCompleted'],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'dueDate': dueDate.toString(),
      'priority': priority,
      'isArchived': isArchived,
      'isStarred': isStarred,
      'markedCompleted': markedCompleted
    };
  }
}