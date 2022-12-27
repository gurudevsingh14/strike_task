import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:strike_task/model/categories.dart';
import 'package:strike_task/model/sub_task_model.dart';
import '../model/task_model.dart';

class TaskProvider extends ChangeNotifier{
  Task _selectedTask=Task(category: TaskCategory(name: ""));

  Task get selectedTask => _selectedTask;

  set selectedTask(Task value) {
    _selectedTask = value;
    notifyListeners();
  }

  List<Task>_taskList=[];

  List<Task> get taskList => _taskList;

  void addTask(Task task) {
    taskList.add(task);
    notifyListeners();
  }
  void deleteTask(Task task) {
    taskList.remove(task);
    notifyListeners();
  }
  void addSubTask(Task task,SubTask subTask){
    task.subTaskList!.add(subTask);
    notifyListeners();
  }
  void addSubTasks(Task task,List<SubTask> subTasks){
    task.subTaskList!.addAll(subTasks);
    notifyListeners();
  }
  void deletesubTask(Task task,int index){
    if(task.subTaskList![index].done==true)
      task.subTaskDoneCount--;
    task.subTaskList!.removeAt(index);
    notifyListeners();
  }
  int getSubTaskSize() => _selectedTask.subTaskList!.length;
  int getSubTaskDoneSize() => _selectedTask.subTaskDoneCount;

  List<Task> getTaskOnSelectedDate(DateTime date) {
    int size=taskList.length;
    int count;
    bool sameDay(DateTime a,DateTime b){
      if(a.year==b.year&&a.month==b.month&&a.day==b.day){
        return true;
      }
      return false;
    }
    List<Task>temp=[];
    for(int i=0;i<size;i++) {
        if(sameDay(taskList[i].dueDate!, date)) {
          temp.add(taskList[i]);
        }
    }
    return temp;
  }

}