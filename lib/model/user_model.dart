import 'package:flutter/material.dart';
import 'package:strike_task/model/task_model.dart';

class UserModel{
  String? uid;
  String? name;
  String? email;
  List<Task>?taskList;
  List<String>?categoryList;
  String? dp;
  String? cp;
  UserModel({this.uid,this.name,this.taskList,this.categoryList,this.dp,this.cp, this.email});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        uid: data['uid'],
        name: data['name'],
        taskList: data['taskList'],
        categoryList: data['categoryList'],
        dp: data['dp'],
        cp: data['cp'],
        email: data['email']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'name': name,
      'taskList': taskList,
      'categoryList': categoryList,
      'dp': dp,
      'cp': cp,
      'email': email
    };
  }
}