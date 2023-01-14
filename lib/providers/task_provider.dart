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
  List<Task>archivedTaskList=[];
  Map<DateTime,List<Task>>dueDateTaskMap={};
  void initializeDueDateTaskMap(){
    dueDateTaskMap={};
    taskList.forEach((ele) { 
      dueDateTaskMap[ele.dueDate]!=null?dueDateTaskMap[ele.dueDate]!.add(ele):dueDateTaskMap[ele.dueDate!]=[ele];
    });
  }
  void updateProvider(List<Task>taskList){
    print("-------------updating task Provider--------------");
    this.taskList=taskList;
    initializeDueDateTaskMap();
    notifyListeners();
  }
  void addInDueDateTaskMap(Task task){
    dueDateTaskMap[task.dueDate]!=null?dueDateTaskMap[task.dueDate]!.add(task):dueDateTaskMap[task.dueDate!]=[task];
  }
  void deleteFromDueDateTaskMap(Task task){
    if(dueDateTaskMap[task.dueDate]!=null)dueDateTaskMap[task.dueDate]!.remove(task);
    if(dueDateTaskMap[task.dueDate]!.length==0) dueDateTaskMap.remove(task.dueDate);
  }
  int get getSubTaskSize => (_selectedTask.subTaskList!=null)?_selectedTask.subTaskList!.length:0;
  int get getSubTaskDoneSize {
    int count=0;
    if(_selectedTask.subTaskList==null) return 0;
    _selectedTask.subTaskList!.forEach((ele) {
      if(ele.done)count++;
    });
    return count;
  }
  int get getTaskDoneCount {
    int count=0;
    taskList.forEach((task) {
        if(task.isTaskCompleted())count++;
    });
    return count;
  }
  Future<void> fetchTask(String uid)async{
    taskFetchStatus=TaskFetchStatus.loading;
    try{
      taskList=[];
      dueDateTaskMap={};
      dynamic response=await GetApiService().service(endpoint: "tasks/$uid.json");
      if(response!=null){
        response.forEach((k,v) async {
          Task task=Task.fromJson(v);
          await fetchSubTasks(task);
          if(task.isArchived==true){
            archivedTaskList.add(task);
          }else{
            taskList.add(task);
            if(task.dueDate!.year>=DateTime.now().year&&task.dueDate!.month>=DateTime.now().month&&task.dueDate!.day>=DateTime.now().day){
              addInDueDateTaskMap(task);
            }
          }
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
      debugPrint("-----${task.dueDate}-----");
      dynamic response=await PostService().service(endpoint: "tasks/$uid.json",body: task.toJson());
      if(response!=null){
       print(response['name']);
       task.id=response['name'];
        dynamic res= await UpdateService().service(endpoint: "tasks/$uid/${task.id}.json", body: {
          'id': task.id
        });
        taskList.add(task);
        addInDueDateTaskMap(task);
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  void deleteTask(String uid,Task task) async{
    try{
      await DeleteService().service("subTasks/${task.id}.json");
      await DeleteService().service("tasks/$uid/${task.id}.json");
      taskList.remove(task);
       deleteFromDueDateTaskMap(task);
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  archiveTask(Task taskToUpdate)async{
    int index = taskList.indexWhere((element) => element.id == taskToUpdate.id);
    taskList[index].isArchived = true;
    Future.delayed(Duration(microseconds: 1));
    await updateTask(FirebaseAuth.instance.currentUser!.uid,taskList[index]);
    archivedTaskList.add(taskList[index]);
    deleteFromDueDateTaskMap(taskList[index]);
    taskList.removeAt(index);
    notifyListeners();
  }

  unArchiveTask(Task taskToUpdate)async{
    int index = archivedTaskList.indexWhere((element) => element.id == taskToUpdate.id);
    archivedTaskList[index].isArchived = false;
    notifyListeners();
    Future.delayed(Duration(microseconds: 1));
    await updateTask(FirebaseAuth.instance.currentUser!.uid,archivedTaskList[index] );
    taskList.add(archivedTaskList[index]);
    addInDueDateTaskMap(archivedTaskList[index]);
    archivedTaskList.removeAt(index);
    notifyListeners();
  }
  starTask(Task task)async{
    task.isStarred=!task.isStarred!;
    await updateTask(FirebaseAuth.instance.currentUser!.uid,task);
  }
  unStarTask(Task task)async{
    task.isStarred=!task.isStarred!;
    await updateTask(FirebaseAuth.instance.currentUser!.uid,task);
  }
  Future<void> updateTask(String uid,Task task)async{
    try{
      dynamic response=await UpdateService().service(endpoint: "tasks/$uid/${task.id}.json",body: task.toJson());
      if(response!=null){
        print(response.toString());
        debugPrint("-----Task updated-----");
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
        task.subTaskList==null?task.subTaskList=[subTask]:task.subTaskList!.add(subTask);
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
        notifyListeners();
        debugPrint("-----subTask updated-----");
      }
    }catch(e){
      print(e.toString());
    }
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
  int countOfCompletedTasks(){
    return taskList.where((task) => task.isTaskCompleted()==true).toList().length;
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
  Future<void> deleteAllTaskWithCategory(String category)async{
    try{
      final uid=FirebaseAuth.instance.currentUser!.uid;
      taskList.forEach((task)async{
        if(task.category==category){
          await DeleteService().service("subTasks/${task.id}.json");
        }
      });
      archivedTaskList.forEach((task)async{
        if(task.category==category){
          await DeleteService().service("subTasks/${task.id}.json");
        }
      });
      taskList.removeWhere((task) => task.category==category);
      archivedTaskList.removeWhere((task) => task.category==category);
      dynamic response=PutService().service(endpoint: "tasks/$uid.json",
          body: Map.fromIterable(taskList,key: (task) => task.id,value: (task) => task.toJson(),));
      if(response!=null){
        initializeDueDateTaskMap();
        print("------------deleted all tasks-------------");
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  Future<void> markTaskAsCompleted(Task task)async{
    final uid=FirebaseAuth.instance.currentUser!.uid;
    task.markedCompleted=true;
    await updateTask(uid, task);
  }
  Future<void> unMarkTaskAsCompleted(Task task)async{
    final uid=FirebaseAuth.instance.currentUser!.uid;
    task.markedCompleted=false;
    await updateTask(uid, task);
  }
  void disposeValues() {
    taskFetchStatus=TaskFetchStatus.nil;
    taskList=[];
    dueDateTaskMap={};
    archivedTaskList=[];
  }
}