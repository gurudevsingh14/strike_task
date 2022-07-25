import 'package:flutter/material.dart';

import '../model/task_model.dart';

class TaskProvider extends ChangeNotifier{
  TaskModel _selectedTask=TaskModel();

  TaskModel get selectedTask => _selectedTask;

  set selectedTask(TaskModel value) {
    _selectedTask = value;
    notifyListeners();
  }

  List<TaskModel>_taskList=[];

  List<TaskModel> get taskList => _taskList;

  void addTask(TaskModel task) {
    taskList.add(task);
    notifyListeners();
  }
  void deleteTask(TaskModel task) {
    taskList.remove(task);
    notifyListeners();
  }
}