import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:strike_task/enum/enums.dart';
import 'package:strike_task/model/sub_task_model.dart';
import 'package:strike_task/services/api_services/get_service.dart';
import 'package:strike_task/services/api_services/post_service.dart';
import 'package:strike_task/services/api_services/put_service.dart';
import 'package:strike_task/services/api_services/update_service.dart';
import '../model/task_model.dart';

class TaskProvider extends ChangeNotifier{
  Task _selectedTask=Task();

  Task get selectedTask => _selectedTask;
  TaskFetchStatus taskFetchStatus=TaskFetchStatus.nil;
  set selectedTask(Task value) {
    _selectedTask = value;
    notifyListeners();
  }

  List<Task>taskList=[];

  Future<void> fetchTask(String uid)async{
    taskFetchStatus=TaskFetchStatus.loading;
    try{
      dynamic response=await GetApiService().service(endpoint: "tasks/$uid.json");
      if(response!=null){
        response.forEach((k,v)=>taskList.add(Task.fromJson(v)));
      }
    }catch(e){
      print(e);
    }
    taskFetchStatus=TaskFetchStatus.fetched;
    debugPrint("-------tasks fetched---------");
    notifyListeners();
  }
  Future<void> addTask(String uid,Task task) async{
    try{
      debugPrint("----------");
      dynamic response=await PostService().service(endpoint: "tasks/$uid.json",body: task.toJson());

      if(response!=null){
       print(response['name']);
       task.id=response['name'];
        dynamic res= await UpdateService().service(endpoint: "tasks/$uid/${task.id}.json", body: {
          'id': task.id
        });
        taskList.add(task);
      }
    }catch(e){
      print(e.toString());
    }
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