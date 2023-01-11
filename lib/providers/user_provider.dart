import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/global_context.dart';
import 'package:strike_task/enum/enums.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/services/api_services/get_service.dart';
import 'package:strike_task/services/api_services/put_service.dart';
import 'package:strike_task/model/user_model.dart';
import 'package:strike_task/services/api_services/update_service.dart';
import 'package:strike_task/services/storage_service.dart';

import '../constants/check_date.dart';
import '../model/task_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  ProfileStatus _profileStatus = ProfileStatus.nil;
  ProfileStatus? get getProfileStatus {
    return _profileStatus;
  }
  Map<DateTime,List<Task>>dueDateTaskMap={};

  void update(Map<DateTime,List<Task>>dueDateTaskMap)async {
    this.dueDateTaskMap=dueDateTaskMap;
    DateTime currDate=DateTime.now();
    if(currentUser==null) return;
    int currStreak=0;
    dueDateTaskMap.forEach((key, value) async {
      if(key.day==currDate.day&&key.month==currDate.month&&key.year==currDate.year){
        int countDone=0;
        value.forEach((task) {
          if(task.isTaskCompleted()) countDone++;
        });
        if(countDone==value.length){
          currStreak=1;
        }
      }
    });
    if(currStreak==0) return;
    if(currentUser!.prevStreakDate!=null){
      DateTime prevDate=currentUser!.prevStreakDate!;
      if(prevDate.day==currDate.day&&prevDate.month==currDate.month&&prevDate.year==currDate.year) return;
      if(isDateConsecutive(prevDate,currDate)){
        if(currStreak==1){
          currentUser!.prevStreakDate=currDate;
          currentUser!.streak+=currStreak;
          currentUser!.highestStreak=max(currentUser!.highestStreak, currentUser!.streak);
          await updateUser(currentUser!);
        }
      }else{
        currentUser!.prevStreakDate=currDate;
        currentUser!.streak=currStreak;
        currentUser!.highestStreak=max(currentUser!.highestStreak, currentUser!.streak);
        await updateUser(currentUser!);
      }
    }else{
      currentUser!.prevStreakDate=currDate;
      currentUser!.streak=currStreak;
      currentUser!.highestStreak=max(currentUser!.highestStreak, currentUser!.streak);
      await updateUser(currentUser!);
    }
  }
  Future<void> updateUser(UserModel user)async{
    try{
      dynamic response=await UpdateService().service(endpoint: "users/${currentUser!.uid}.json", body: user.toJson());
      if(response!=null){
        currentUser=user;
        notifyListeners();
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<String>? registerUser(UserModel user) async {
    try {
      dynamic response = await PutService().service(endpoint: "users/${user.uid}.json", body: user.toJson());
      if (response != null) {
        print(response.toString());
        currentUser = user;
        _profileStatus = ProfileStatus.fetched;
        notifyListeners();
        return "successful";
      }
    } catch (e) {
      print(e);
      return e.toString();
    }

    return "unsuccessful";
  }

  Future<String?> setUser(String uid) async {
    _profileStatus=ProfileStatus.loading;
    try {
      dynamic response = await GetApiService().service(endpoint: "users/${uid}.json");

      if (response != null) {
        currentUser = UserModel.fromJson(response);
        _profileStatus = ProfileStatus.fetched;
        notifyListeners();
        return "successful";
      }
    } catch (e) {
      print(e.toString());
    }
    _profileStatus=ProfileStatus.nil;
    notifyListeners();
    return "unsuccessful";
  }
  Future<void> changeDp(File image)async{
    try{
      String? url=await getImageUrl(image,"users/${currentUser!.uid!}/dp");
      print(url);
      dynamic response=await UpdateService().service(endpoint: 'users/${currentUser!.uid}.json', body: {'dp':url});
      print(response.toString());
      if(response!=null){
        currentUser!.dp=url;
      }
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
}

