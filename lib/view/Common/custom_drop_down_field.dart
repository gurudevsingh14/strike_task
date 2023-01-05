import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/controller/category_controller.dart';

import '../../constants/category_list.dart';
import '../../constants/constants.dart';

class CustomDropDownField extends StatelessWidget {
  String? category;
  String? Function(String?)? validator;
  CustomDropDownField({this.validator});
  @override
  Widget build(BuildContext context) {
    final categoryController=Provider.of<CategoryController>(context);
    return DropdownButtonFormField<String>(
      isExpanded: true,
      validator: validator,
      value: category,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        labelText: 'Select category',
        labelStyle:
        TextStyle(fontWeight: FontWeight.w500, color: mutedTextColor),
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.8,
              color: mutedlineColor,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.8,
              color: mutedlineColor,
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
      icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
      onChanged: (newValue) {
        category = newValue;
        categoryController.selectedCategory=newValue;
      },
      items: categoryList
          .map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem(
          value: value,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
          ),
          enabled: true,
        );
      }).toList(),
    );
  }
}

