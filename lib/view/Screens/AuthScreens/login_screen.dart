import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/model/user_model.dart';
import 'package:strike_task/providers/user_provider.dart';
import 'package:strike_task/services/auth_services/auth_service.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Screens/AuthScreens/components/gradientTextField.dart';

import '../../../constants/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email=TextEditingController();

  TextEditingController password=TextEditingController();
  bool loadScreen = false;
  @override
  Widget build(BuildContext context) {
    AuthService _auth=AuthService(FirebaseAuth.instance,context);
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2,1],
            colors : [Color(0xFF4ecdc4),Color(0xFF556270)]
            // colors: [Color(0xFF67b26f),Color(0xFF4ca2cd)]
     )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Card(
              color: Colors.teal.shade200,
              margin:   EdgeInsets.zero,
              elevation: 12,
              child: Image.asset('assets/images/welcome.png',height: displayHeight(context)*0.32,width: displayWidth(context),fit: BoxFit.contain),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(130),bottomLeft: Radius.circular(130)),
              ),
            ),
            Center(
              child: Container(
                width: displayWidth(context)*0.85,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(height: displayHeight(context)*0.2,),
                      SizedBox(height: displayWidth(context)*0.09,),
                      Text("Welcome Back",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w500,color: whiteColor),),
                      SizedBox(height: displayHeight(context)*0.03,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Login with your account", style: TextStyle(color: whiteColor,fontSize: 14),),
                          Text("   or   ", style: TextStyle(color: whiteColor,fontSize: 14),),
                        InkWell(child: Text("skip", style: TextStyle(color: whiteColor,fontSize: 14,fontWeight: FontWeight.bold),),
                        onTap: (){
                          Navigator.pushReplacementNamed(context, '/HomeScreen');
                        }),
                      ],),
                      SizedBox(height: displayHeight(context)*0.05,),
                      GradientTextField(hintText: "Email",icon: Icon(Icons.email,color: primaryColor,),textController: email),
                      SizedBox(height: 20,),
                      GradientTextField(hintText: "Password",icon: Icon(Icons.lock,color: primaryColor,),textController: password,obsureText: true,),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                          child: Text(
                            "Forgot Password?",style: TextStyle(color: whiteColor),
                          ),
                        )],
                      ),
                      (loadScreen)
                          ? const Center(
                        child: CircularProgressIndicator(),
                      ):SizedBox(),
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
                    loadScreen=true;
                  });
                  var response=await _auth.signIn(email: email.text, password: password.text);
                  if(response=="valid") {
                    String? res=await userProvider.setUser(_auth.getAuth().currentUser!.uid);
                    if(res=="successful"){
                      Navigator.pushReplacementNamed(context, "/HomeScreen");
                    } else if(res=="unsuccessful"){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("check connection!!try again")));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res!)));
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("invalid")));
                    setState(() {
                      loadScreen=false;
                    });
                  }
                },
                fontSize: 16,
                text: "Login",
                width: displayWidth(context)*0.85,
                elevation: 9,
                height: 0.05*displayHeight(context),
                radius: 20,
                linearGradient: LinearGradient(
                  colors: [primaryColor,primayDarkColor,],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",style: TextStyle(color: whiteColor),),
                  InkWell(
                    child: Text("Sign up",style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold),),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/RegisterScreen');
                    },
                  )
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,

      ),
    );
  }
}
