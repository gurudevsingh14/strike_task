import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/controller/dateTime_controller.dart';

import '../../constants/constants.dart';

class DatePickerField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller= Provider.of<DateTimeController>(context);
    DateTime selectedDate=controller.selectedDate;
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: (){
          showDatePicker(context: context, 
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(selectedDate.year+10),
          ).then((value) {
            if(value!=null) {
                controller.selectedDate=value;
                // dueDateController=TextEditingController(text: value.toIso8601String());
              }
          });
        },
        child: TextFormField(
          enabled: false,
           controller: TextEditingController()..text = '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_month),
            suffixIcon: Icon(Icons.arrow_drop_down),
            labelText: 'Due date',
            labelStyle: TextStyle(fontWeight: FontWeight.w500,color: mutedTextColor,overflow: TextOverflow.ellipsis ),
            // isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.8,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
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
        ),
      ),
    );
  }
}
