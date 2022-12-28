import 'dart:developer';

import 'package:flutter/material.dart';

class Service_Api{
  String base_url;
  Service_Api(this.base_url);
}
Service_Api ServiceApi=Service_Api("https://strike-task-default-rtdb.firebaseio.com/");