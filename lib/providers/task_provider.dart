import 'package:flutter/material.dart';

import '../model/task_model.dart';

class TaskProvider extends ChangeNotifier{
  List<TaskModel>_taskList=[];

  List<TaskModel> get taskList => _taskList;

  void addTask(TaskModel task) {
    taskList.add(task);
    notifyListeners();
  }
  void deleteTask(int index) {
    taskList.removeAt(index);
    notifyListeners();
  }
}