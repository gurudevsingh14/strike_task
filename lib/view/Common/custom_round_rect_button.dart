import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';

class CustomRoundRectButton extends StatelessWidget {
  final String text;
  double? radius;
  double? height;
  double? width;
  double? fontSize;
  VoidCallback? callBack;
  CustomRoundRectButton({Key? key,
    required this.text,required this.height,this.width,this.fontSize,this.callBack,this.radius=10});
  VoidCallback nothing = (){};
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??displayWidth(context),
      child: MaterialButton(
          onPressed: callBack??nothing,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius!),
          ),
          height: height!,
          color: primaryColor,
          //padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            text,
            style: TextStyle(color: Colors.white,fontSize: fontSize),
          )),
    );
  }
}