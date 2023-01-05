import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:strike_task/enum/enums.dart';
import 'package:strike_task/model/sub_task_model.dart';
import 'package:strike_task/services/api_services/delete_service.dart';
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
  int get getSubTaskSize => (_selectedTask.subTaskList!=null)?_selectedTask.subTaskList!.length:0;
  int get getSubTaskDoneSize {
    int count=0;
    _selectedTask.subTaskList!.forEach((ele) {
      if(ele.done)count++;
    });
    return count;
  }
  Future<void> fetchTask(String uid)async{
    taskFetchStatus=TaskFetchStatus.loading;
    try{
      dynamic response=await GetApiService().service(endpoint: "tasks/$uid.json");
      if(response!=null){
        response.forEach((k,v) async {
          Task task=Task.fromJson(v);
          await fetchSubTasks(task);
          return taskList.add(task);
        });
      }
    }catch(e){
      print(e);
    }
    taskFetchStatus=TaskFetchStatus.fetched;
    debugPrint("-------tasks fetched---------");
    notifyListeners();
  }
  Future<void> fetchSubTasks(Task task)async{
    try{
      dynamic response=await GetApiService().service(endpoint: "subTasks/${task.id}.json");
      if(response!=null){
        response.forEach((k,v)=>task.subTaskList!.add(SubTask.fromJson(v)));
      }
    }catch(e){
      print(e);
    }
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
  void deleteTask(String uid,Task task) async{
    try{
      dynamic response=await DeleteService().service("tasks/$uid/${task.id}.json");
      if(response==null){
        taskList.remove(task);
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  Future<void> addSubTask(Task task,SubTask subTask)async{
    try{
      debugPrint("-----Adding subtask-----");
      dynamic response=await PostService().service(endpoint: "subTasks/${task.id}.json",body: subTask.toJson());
      if(response!=null){
        print(response['name']);
        subTask.id=response['name'];
        dynamic res= await UpdateService().service(endpoint: "subTasks/${task.id}/${subTask.id}.json", body: {
          'id': subTask.id
        });
        task.subTaskList!.add(subTask);
        debugPrint("-----subtask Added-----");
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  void updateSubTask(Task task,SubTask subTask)async{
    try{
      dynamic response=await UpdateService().service(endpoint: "subTasks/${task.id}/${subTask.id}.json",body: subTask.toJson());
      if(response!=null){
        print(response.toString());
        debugPrint("-----subTask updated-----");
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  void deleteSubTask(Task task,SubTask subTask) async{
    try{
      dynamic response=await DeleteService().service("subTasks/${task.id}/${subTask.id}.json");
      if(response==null){
        task.subTaskList!.remove(subTask);
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
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