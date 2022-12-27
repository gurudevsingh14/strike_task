import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/model/user_model.dart';
import 'package:strike_task/providers/user_provider.dart';
import 'package:strike_task/services/auth_services/auth_service.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Screens/AuthScreens/components/gradientTextField.dart';
import 'package:strike_task/model/user_model.dart';
import '../../../constants/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool loadScreen = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    AuthService _auth = AuthService(FirebaseAuth.instance, context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 1],
              colors: [Color(0xFF4ecdc4), Color(0xFF556270)]
              // colors: [Color(0xFF67b26f),Color(0xFF4ca2cd)]
              )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Card(
              color: Colors.teal.shade200,
              margin: EdgeInsets.zero,
              elevation: 12,
              child: Image.asset('assets/images/welcome.png',
                  height: displayHeight(context) * 0.32,
                  width: displayWidth(context),
                  fit: BoxFit.contain),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(130),
                    bottomLeft: Radius.circular(130)),
              ),
            ),
            Center(
              child: Container(
                width: displayWidth(context) * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(height: displayHeight(context)*0.2,),
                      SizedBox(
                        height: displayWidth(context) * 0.09,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w500,
                            color: whiteColor),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      Text(
                        "Create your account",
                        style: TextStyle(color: whiteColor, fontSize: 14),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.03,
                      ),
                      // SizedBox(height: 20,),
                      GradientTextField(
                          hintText: "Name",
                          icon: Icon(
                            Icons.person,
                            color: primaryColor,
                          ),
                          textController: name),
                      SizedBox(
                        height: 20,
                      ),
                      GradientTextField(
                        hintText: "Email",
                        icon: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        textController: email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GradientTextField(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        obsureText: true,
                        textController: password,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GradientTextField(
                        hintText: "Confirm Password",
                        icon: Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        obsureText: true,
                        textController: confirmPassword,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      (loadScreen)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomRoundRectButton(
                callBack: () async {
                  setState(() {
                    loadScreen = true;
                  });
                  if (password.text == confirmPassword.text) {
                    String? response = await _auth.signUp(
                        name: name.text,
                        email: email.text,
                        password: password.text);
                    if (response == "valid") {
                      UserModel user = UserModel(
                          name: name.text,
                          email: email.text,
                          uid: _auth.getAuth().currentUser!.uid);
                      String? res = await userProvider
                          .registerUser(user);
                      if (res == "successful") {
                        Navigator.pushReplacementNamed(context, "/HomeScreen");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Something went wrong! try again..")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Something went wrong! try again..")));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("password did not matched")));
                  }
                  setState(() {
                    loadScreen = false;
                  });
                },
                fontSize: 16,
                text: "Register",
                width: displayWidth(context) * 0.85,
                elevation: 9,
                height: 0.05 * displayHeight(context),
                radius: 20,
                linearGradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primayDarkColor,
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: whiteColor),
                  ),
                  InkWell(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          color: whiteColor, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/LoginScreen');
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
