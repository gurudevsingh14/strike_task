import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Common/custom_text_field.dart';
import 'package:strike_task/view/Common/date_picker_field.dart';
import 'package:strike_task/view/Common/priority_tag.dart';

class CreateTaskModal extends StatelessWidget {
  const CreateTaskModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Create Task',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 12,),
          CustomTextField(label : 'Task name'),
          SizedBox(height: 16,),
          CustomTextField(label: 'Add description',height: 100,),
          SizedBox(height: 16,),
          DatePickerField(),
          SizedBox(height: 8,),
          Text('  Priority',style: TextStyle(color: mutedTextColor),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: priorityList.map((value) => SizedBox(height: 35,child: PriorityTag(priorityObj: value,fontSize: 16,))).toList(),
          ),
          SizedBox(height: 16,),
          CustomRoundRectButton(text: 'Create Task', height: 50,fontSize: 18,)
        ],
      ),
    );
  }
}
