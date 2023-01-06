import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../enum/enums.dart';
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
  Future<void> fetchCategory()async{
    categoryFetchStatus=CategoryFetchStatus.loading;
    try{
      String uid=FirebaseAuth.instance.currentUser!.uid;
      dynamic response=await GetApiService().service(endpoint: "category/$uid.json");
      if(response!=null){
        response.forEach((k,v) async {
          categoryList.add(k);
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
      dynamic response=await PutService().service(endpoint: "category/$uid.json",body: {
        value:""
      });
      if(response!=null)
        categoryList.add(value);
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  void deleteTask(String value) async{
    try{
      String uid=FirebaseAuth.instance.currentUser!.uid;
      dynamic response=await DeleteService().service("category/$uid/$value.json");
      if(response==null){
        categoryList.remove(value);
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
}