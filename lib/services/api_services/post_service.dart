import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/global_context.dart';
import '../../constants/service_api.dart';

class PostService {
  Future<dynamic> service(
      {String? endpoint,
      Map<String, dynamic>? body,
      String? taskMessage,
      bool? dislayMessage}) async {
    try {
      debugPrint('post body : ${body.toString()}');
      var response = await http.post(Uri.parse(ServiceApi.base_url + endpoint!),
          body: json.encode(body));
      int statusCode = response.statusCode;
      switch (statusCode) {
        case 200:
          if (dislayMessage!) {
            ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
                .showSnackBar(SnackBar(content: Text(taskMessage!)));
          }
          debugPrint('post response : ${response.body.toString()}');
          return json.decode(response.body);
        case 400:
          ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
              .showSnackBar(const SnackBar(content: Text('Bad request')));
          return null;
        case 401:
          ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
              .showSnackBar(const SnackBar(content: Text('Unauthorised')));
          return null;
        default:
          ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
              .showSnackBar(const SnackBar(
                  content: Text('Network connectivity problem')));
          return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
