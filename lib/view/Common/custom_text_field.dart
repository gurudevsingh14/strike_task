import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/textfield_controller.dart';

class CustomTextField extends StatelessWidget {
  String? label;
  double? height;
  CustomTextField({required this.label,this.height});

  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<TextFieldController>(context);
    return SizedBox(
      height: height??50,
      child: TextFormField(
        minLines: 4,
        maxLines: 16,
        decoration: InputDecoration(
          fillColor: controller.bgColor,
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.w500,color: mutedTextColor ),
          // isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: mutedlineColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.lightBlue,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
