import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/category_controller.dart';
import 'package:strike_task/controller/dateTime_controller.dart';
import 'package:strike_task/controller/priority_select_controller.dart';
import 'package:strike_task/controller/screen_controller.dart';
import 'package:strike_task/controller/table_calendar_controller.dart';
import 'package:strike_task/controller/textfield_controller.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/view/Common/body_with_appbar.dart';
import 'package:strike_task/view/Common/create_task_modal.dart';
import 'package:strike_task/view/Common/custom_text_field.dart';
import 'package:strike_task/view/Screens/HomeScreen/home_screen.dart';
import 'package:strike_task/view/Screens/TaskDetailScreen/task_detail_screen.dart';
import 'package:strike_task/view/Common/create_task_modal.dart';

void main() {
  // this is root of the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => ScreenController(),),
        ChangeNotifierProvider(create: (context) => TextFieldController(),),
        ChangeNotifierProvider(create: (context) => DateTimeController(),),
        ChangeNotifierProvider(create: (context) => PrioritySelectController(),),
        ChangeNotifierProvider(create: (context) => TableCalendarController(),),
        ChangeNotifierProvider(create: (context) => TaskProvider(),),
        ChangeNotifierProvider(create: (context) => CategoryController(),),
      ],
      child: MaterialApp(
        routes: {
          '/TaskDetail' : (context) =>TaskDetailScreen(),
          '/CreateTask' : (context) => CreateTaskModal()
        },
        theme: ThemeData(
          fontFamily: lato,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
        ),
        debugShowCheckedModeBanner: false,
        home: BodyWithAppBar(),
      ),
    );
  }
}