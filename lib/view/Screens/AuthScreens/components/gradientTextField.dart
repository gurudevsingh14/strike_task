import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/device_size.dart';

import '../../../../constants/constants.dart';
import '../../../../controller/textfield_controller.dart';

class GradientTextField extends StatefulWidget {
  String? hintText;
  double? width;
  Icon? icon;
  bool obsureText;
  TextEditingController? textController;
  String? Function(String?)? validator;
  GradientTextField({this.hintText,this.textController,this.validator,this.width,this.icon,this.obsureText=false});


  @override
  State<GradientTextField> createState() => _GradientTextFieldState();
}

class _GradientTextFieldState extends State<GradientTextField> {
  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<TextFieldController>(context);
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white,primayLightColor.withOpacity(0.3)]),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: TextFormField(
        obscureText: widget.obsureText,
        style: TextStyle(decoration: TextDecoration.none,),
        controller: widget.textController,
        validator: widget.validator,
        minLines: 1,
        maxLines: widget.obsureText?1:5,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: widget.icon,
          hintText: widget.hintText??"Unnamed",
          // labelText: widget.label??"Unnamed",
          // labelStyle: TextStyle(fontWeight: FontWeight.w500,color: mutedTextColor ),
          // isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.8,
                color: mutedlineColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.8,
                color: Colors.lightBlue,
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.8,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.8,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}