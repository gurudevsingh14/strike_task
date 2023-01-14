import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/controller/screen_controller.dart';
import 'package:strike_task/providers/category_provider.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/providers/user_provider.dart';

class AppProviders {
  static List<dynamic> getProviders(BuildContext context) {
    return [
      Provider.of<ScreenController>(context, listen: false),
      Provider.of<TaskProvider>(context, listen: false),
      Provider.of<CategoryProvider>(context, listen: false),
      Provider.of<UserProvider>(context, listen: false),
    ];
  }

  static void disposeAllProviders(BuildContext context) {
    getProviders(context).forEach((Provider) {
      Provider.disposeValues();
    });
  }
}