import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomDropDownField extends StatefulWidget {
  String email='gurudev620.gs@gmail.com';

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      // value: dropdownValue,
      value: widget.email,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: mutedlineColor,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
        width: 1.5,
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
        'gurudev620.gs@gmail.com','gurudev2001@hotmail.com','gurudev123@gmail.com'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          enabled: true,
        );
      }).toList(),
    );
  }
}
