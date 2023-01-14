import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/providers/category_provider.dart';
import 'package:strike_task/controller/dateTime_controller.dart';
import 'package:strike_task/controller/priority_select_controller.dart';
import 'package:strike_task/controller/screen_controller.dart';
import 'package:strike_task/controller/table_calendar_controller.dart';
import 'package:strike_task/controller/textfield_controller.dart';
import 'package:strike_task/enum/enums.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/providers/user_provider.dart';
import 'package:strike_task/view/Common/body_with_appbar.dart';
import 'package:strike_task/view/Common/create_task_modal.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Common/custom_text_field.dart';
import 'package:strike_task/view/Screens/AuthScreens/login_screen.dart';
import 'package:strike_task/view/Screens/AuthScreens/register_screen.dart';
import 'package:strike_task/view/Screens/HomeScreen/home_screen.dart';
import 'package:strike_task/view/Screens/AuthScreens/login_screen.dart';
import 'package:strike_task/view/Screens/TaskDetailScreen/task_detail_screen.dart';
import 'package:strike_task/view/Common/create_task_modal.dart';

import 'constants/device_size.dart';
import 'constants/global_context.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // this is root of the app
  runApp(MaterialApp(home: SplashScreen(),debugShowCheckedModeBanner: false,));
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.black,
        splash: Center(
          child: SizedBox(
              height: 300,
              width: 240,
              child: Image.asset('assets/images/strike_task.gif',fit: BoxFit.cover,)
          ),
        ),
      duration: 1500,
      nextScreen: StrikeTask(),
    );
  }
}

class StrikeTask extends StatefulWidget {
  @override
  State<StrikeTask> createState() => _StrikeTaskState();
}

class _StrikeTaskState extends State<StrikeTask> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenController(),),
        ChangeNotifierProvider(create: (context) => TextFieldController(),),
        ChangeNotifierProvider(create: (context) => DateTimeController(),),
        ChangeNotifierProvider(create: (context) => PrioritySelectController(),),
        ChangeNotifierProvider(create: (context) => TableCalendarController(),),
        ChangeNotifierProvider(create: (context) => TaskProvider(),),
        ChangeNotifierProvider(create: (context) => CategoryProvider(),),
        ChangeNotifierProvider(create: (context)=>UserProvider()),
        ChangeNotifierProxyProvider<TaskProvider,UserProvider>(
            create: (context) => UserProvider(),
            update: (context, taskProvider, user) => user!..update(taskProvider.dueDateTaskMap),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/StrikeTask' : (context) => StrikeTask(),
          '/HomeScreen' : (context) => BodyWithAppBar(),
          '/TaskDetail' : (context) =>TaskDetailScreen(),
          '/CreateTask' : (context) => CreateTaskModal(),
          '/RegisterScreen' : (context) => RegisterScreen(),
          '/LoginScreen' : (context) => LoginScreen(),
        },
        theme: ThemeData(
          fontFamily: lato,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalContext.contextKey,
        home: FutureBuilder(
          future: getPref(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            final user=Provider.of<UserProvider>(context);
            if(snapshot.connectionState==ConnectionState.active||snapshot.connectionState==ConnectionState.done){
              if(snapshot.hasData){
                if(snapshot.data!) {
                  return BodyWithAppBar();
                }
                else return LoginScreen();
              } else return LoginScreen();
            } else return SplashScreen();
          },
        ),
      ),
    );
  }
}

Future<bool> getPref() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = false;
  if(prefs.containsKey('login')){
    isLoggedIn = prefs.getBool('login')!;
  }
  return isLoggedIn;
}

Future<void> setPref(bool val) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('login', val);
}
