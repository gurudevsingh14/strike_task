import 'package:flutter/material.dart';
import 'package:strike_task/enum/enums.dart';
import 'package:strike_task/services/api_services/get_service.dart';
import 'package:strike_task/services/api_services/put_service.dart';
import 'package:strike_task/model/user_model.dart';

class UserProvider extends ChangeNotifier{
  UserModel? currentUser;
  ProfileStatus _profileStatus = ProfileStatus.nil;

  ProfileStatus? get getProfileStatus {
    return _profileStatus;
  }

  UserModel get getCurrentUser{
    return currentUser??UserModel();
  }

  Future<String?>registerUser(UserModel user) async {
    try{
      dynamic response=await PutService().service(endpoint: "users/${user.uid}.json", body: user.toJson());
      if(response!=null){
        print(user.name);
        currentUser=user;
        print(currentUser!.name);
        _profileStatus=ProfileStatus.fetched;
        notifyListeners();
        return "successful";
      }
    } catch(e) {
      print(e);
      return e.toString();
    }
    return "unsuccessful";
  }
  Future<String?>setUser(String uid) async {
    try{
      dynamic response=await GetApiService().service(endpoint: "users/${uid}");
      if(response!=null)  {
        currentUser=UserModel.fromJson(response.data);
        _profileStatus=ProfileStatus.fetched;
        notifyListeners();
        return "successful";
      }
    }catch(e){
      print(e.toString());
    }
    return "unsuccessful";
  }

}