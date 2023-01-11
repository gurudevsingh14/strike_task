import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../enum/enums.dart';
import '../model/task_model.dart';
import '../services/api_services/delete_service.dart';
import '../services/api_services/get_service.dart';
import '../services/api_services/post_service.dart';
import '../services/api_services/put_service.dart';
import '../services/api_services/update_service.dart';

class CategoryProvider extends ChangeNotifier{
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;
  CategoryFetchStatus categoryFetchStatus=CategoryFetchStatus.nil;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }
  List<String>categoryList=[];
  List<Task>taskList=[];
  Future<void> fetchCategory()async{
    categoryFetchStatus=CategoryFetchStatus.loading;
    try{
      categoryList=[];
      String uid=FirebaseAuth.instance.currentUser!.uid;
      dynamic response=await GetApiService().service(endpoint: "users/$uid/category.json");
      if(response!=null){
        response.forEach((k,v){
          categoryList.add(v);
        });
      }
    }catch(e){
      print(e);
    }
    categoryFetchStatus=CategoryFetchStatus.fetched;
    debugPrint("-------category fetched---------");
    notifyListeners();
  }
  Future<void> addcategory(String value)async{
    try{
      String uid=FirebaseAuth.instance.currentUser!.uid;
      categoryList.add(value);
      dynamic response=await UpdateService().service(endpoint: "users/$uid.json",body:{'category':categoryList});
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  Future<void> deleteAllTaskWithCategory(String category)async{
    try{
      final uid=FirebaseAuth.instance.currentUser!.uid;
      taskList=[];
      dynamic response=await GetApiService().service(endpoint: "tasks/$uid.json");
      if(response!=null){
        Map<String,dynamic>body={};
        response.forEach((k,v) async {
          if(v['category']!=category){
            body[k]=v;
            taskList.add(Task.fromJson(v));
          }else{
            await DeleteService().service("subTasks/$k.json");
          }
        });
        response=await PutService().service(endpoint: "tasks/$uid.json", body: body);
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> deleteCategory(String value) async{
    try{
      String uid=FirebaseAuth.instance.currentUser!.uid;
      categoryList.remove(value);
      dynamic response=await UpdateService().service(endpoint: "users/$uid.json",body: {'category':categoryList});
      await deleteAllTaskWithCategory(value);
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
}