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
    if(task.subTaskList[index].done==true)
      task.SubTaskDoneCount--;
    task.subTaskList.removeAt(index);
    notifyListeners();
  }
  int getSubTaskSize() => _selectedTask.subTaskList.length;
  int getSubTaskDoneSize() => _selectedTask.SubTaskDoneCount;

  List<TaskModel> getTaskOnSelectedDate(DateTime date) {
    int size=taskList.length;
    int count;
    bool sameDay(DateTime a,DateTime b){
      if(a.year==b.year&&a.month==b.month&&a.day==b.day){
        return true;
      }
      return false;
    }
    List<TaskModel>temp=[];
    for(int i=0;i<size;i++) {
        if(sameDay(taskList[i].dueDate!, date)) {
          temp.add(taskList[i]);
        }
    }
    return temp;
  }

}