import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/textfield_controller.dart';

class CustomTextField extends StatelessWidget {
  String? label;
  TextEditingController? textController;
  CustomTextField({this.label,required this.textController});


  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<TextFieldController>(context);
    return TextFormField(
      controller: textController,
      minLines: 1,
      maxLines: 16,
      decoration: InputDecoration(
        fillColor: controller.bgColor,
        labelText: label??"Unnamed",
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
      ),
    );
  }
}
