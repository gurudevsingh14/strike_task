import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:strike_task/constants/global_context.dart';
import 'package:strike_task/constants/service_api.dart';

class DeleteService {
  Future<dynamic?>service(String? endPoint)async{
    try{
      var response= await http.delete(Uri.parse(ServiceApi.base_url+endPoint!));
      int statusCode=response.statusCode;
      switch(statusCode){
        case 200:
          return json.decode(response.body);
        default:
          ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
              .showSnackBar(const SnackBar(content: Text('Some error occured')));
          return null;
      }
    }catch(e){
      print(e.toString());
    }
  }
}