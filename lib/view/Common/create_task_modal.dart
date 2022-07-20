import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/view/Common/custom_drop_down_field.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Common/custom_text_field.dart';
import 'package:strike_task/view/Common/date_picker_field.dart';
import 'package:strike_task/view/Common/priority_tag.dart';

import '../../controller/priority_select_controller.dart';

class CreateTaskModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller= Provider.of<PrioritySelectController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Create Task',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 12,),
            CustomDropDownField(),
            SizedBox(height: 16,),
            CustomTextField(label : 'Task name'),
            SizedBox(height: 16,),
            CustomTextField(label: 'Add description'),
            SizedBox(height: 16,),
            DatePickerField(),
            SizedBox(height: 8,),
            Text('  Priority',style: TextStyle(color: mutedTextColor),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: priorityList.asMap().map((index,value) =>MapEntry(index,
                  SizedBox(height: 35,child: InkWell(
                      onTap: (){
                        controller.selectedIndex=index;
                      },
                      child: PriorityTag(priorityObj: value,fontSize: 16,selected: controller.selectedIndex==index?true:false,))
                  ))
                  ).values.toList(),
            ),
            SizedBox(height: 16,),
            CustomRoundRectButton(text: 'Create Task', height: 50,fontSize: 18,)
          ],
        ),
      ),
    );
  }
}
