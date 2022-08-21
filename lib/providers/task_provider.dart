import 'package:flutter/material.dart';
import 'package:strike_task/model/sub_task_model.dart';
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
  void addSubTask(TaskModel task,SubTask subTask){
    task.subTaskList.add(subTask);
    notifyListeners();
  }
  void addSubTasks(TaskModel task,List<SubTask> subTasks){
    task.subTaskList.addAll(subTasks);
    notifyListeners();
  }
  void deletesubTask(TaskModel task,int index){
    task.subTaskList.removeAt(index);
    notifyListeners();
  }
  int getSubTaskSize() => _selectedTask.subTaskList.length;
  int getSubTaskDoneSize() => _selectedTask.SubTaskDoneCount;
}