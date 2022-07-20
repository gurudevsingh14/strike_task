import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomDropDownField extends StatefulWidget {
  String email='home';

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      // value: dropdownValue,
      value: widget.email,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        labelText: 'Select category',
        labelStyle: TextStyle(fontWeight: FontWeight.w500,color: mutedTextColor ),
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
      ),
      icon: Icon(Icons.arrow_drop_down,color: Colors.grey),
      onChanged: (newValue) {
        setState(() {
          widget.email=newValue!;
        });
      },
      items: <String>[
        'home','office','study'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,overflow: TextOverflow.ellipsis,),
          enabled: true,
        );
      }).toList(),
    );
  }
}
