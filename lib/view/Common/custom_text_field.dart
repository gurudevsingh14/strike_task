import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/textfield_controller.dart';

class CustomTextField extends StatefulWidget {
  String? label;
  TextEditingController? textController;
  String? Function(String?)? validator;
  CustomTextField({this.label,required this.textController,this.validator});


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<TextFieldController>(context);
    return TextFormField(
      controller: widget.textController,
      validator: widget.validator,
      minLines: 1,
      maxLines: 16,
      decoration: InputDecoration(
        fillColor: controller.bgColor,
        labelText: widget.label??"Unnamed",
        labelStyle: TextStyle(fontWeight: FontWeight.w500,color: mutedTextColor ),
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
    );
  }
}
