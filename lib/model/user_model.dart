import 'package:flutter/material.dart';
import 'package:strike_task/model/task_model.dart';

class UserModel{
  String? uid;
  String? name;
  String? email;
  List<Task>?taskList;
  List<String>?category;
  String? dp;
  String? cp;
  DateTime? prevStreakDate;
  int streak;
  int highestStreak;
  UserModel({this.uid,this.name,this.taskList,this.category=const ["home","office","study"],this.dp,this.cp, this.email, this.prevStreakDate,
    this.streak=0,this.highestStreak=0
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        uid: data['uid'],
        name: data['name'],
        taskList: data['taskList'],
        category: List<String>.from(data['category']),
        dp: data['dp'],
        cp: data['cp'],
        email: data['email'],
        prevStreakDate: data['prevStreakDate']!=null?DateTime.parse(data['prevStreakDate']):null,
        streak: data['streak']??0,
        highestStreak: data['highestStreak']??0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid':uid,
      'name': name,
      'taskList': taskList,
      'category': category,
      'dp': dp,
      'cp': cp,
      'email': email,
      'prevStreakDate': prevStreakDate!=null?prevStreakDate.toString():null,
      'highestStreak': highestStreak,
      'streak': streak
    };
  }
}