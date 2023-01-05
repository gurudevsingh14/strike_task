import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants/global_context.dart';
import '../../constants/service_api.dart';

class UpdateService {
  Future<dynamic> service(
      {required String endpoint,
      required Map<String, dynamic> body,
      String? taskMessage,
      bool? showMessage}) async {
    try {
      final internetResponse = await InternetAddress.lookup('google.com');
      if (internetResponse.isEmpty) {
        ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
            .showSnackBar(
                const SnackBar(content: Text('No internet connection')));
        return null;
      }

      if (internetResponse.isNotEmpty &&
          internetResponse[0].rawAddress.isNotEmpty) {
        debugPrint('update body : ${body.toString()}');
        var response = await http.patch(
            Uri.parse(ServiceApi.base_url + endpoint),
            body: json.encode(body));
        debugPrint('update response : ${response.body.toString()}');
        int statusCode = response.statusCode;
        switch (statusCode) {
          case 200:
            return json.decode(response.body) as Map<String, dynamic>;
          case 400:
            ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
                .showSnackBar(
                    const SnackBar(content: Text('Some error occurred')));
            return null;
          case 401:
            ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
                .showSnackBar(
                    const SnackBar(content: Text('Some error occurred')));
            return null;
          default:
            ScaffoldMessenger.of(GlobalContext.contextKey.currentContext!)
                .showSnackBar(
                    const SnackBar(content: Text('Some error occurred')));
            return null;
        }
      } else {
        return null;
      }
    } on SocketException catch (_) {
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
