import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants/service_api.dart';

class PutService {
  Future<dynamic> service(
      {required String endpoint, required Map<String, dynamic> body}) async {
    try {
      final internetResponse = await InternetAddress.lookup('google.com');
      if (internetResponse.isEmpty) {
        return;
      }
      if (internetResponse.isNotEmpty &&
          internetResponse[0].rawAddress.isNotEmpty) {
        var response = await http.put(Uri.parse(ServiceApi.base_url + endpoint),
            body: json.encode(body));
        int statusCode = response.statusCode;
        //print(statusCode);
        switch (statusCode) {
          case 200:
            return json.decode(response.body) as Map<String, dynamic>;
          case 400:
            return 'Bad request';
          case 401:
            return 'Unauthorised';
          default:
            break;
        }
      } else {
        return 'no internet';
      }
    } on SocketException catch (_) {
      return 'no internet';
    } catch (e) {}
  }
}
