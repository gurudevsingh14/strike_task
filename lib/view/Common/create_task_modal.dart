import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/view/Common/add_category_button.dart';
import 'package:strike_task/view/Common/custom_drop_down_field.dart';
import 'package:strike_task/view/Common/custom_round_rect_button.dart';
import 'package:strike_task/view/Common/custom_text_field.dart';
import 'package:strike_task/view/Common/date_picker_field.dart';
import 'package:strike_task/view/Common/priority_tag.dart';

import '../../controller/priority_select_controller.dart';

class CreateTaskModal extends StatelessWidget {
  TextEditingController? taskNameController;
  TextEditingController? descriptionController;
  TextEditingController dueDateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PrioritySelectController>(context);
    final taskController=Provider.of<TaskProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Create Task',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 6,
                      child: CustomDropDownField(
                        categoryController: categoryController,
                      )),
                  Flexible(
                      flex: 1,
                      child: Text(
                        'or',
                        style: TextStyle(color: mutedTextColor),
                      )),
                  Flexible(flex: 6, child: AddCategoryButton()),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              CustomTextField(label: 'Task name',textController: taskNameController,),
              SizedBox(
                height: 16,
              ),
              CustomTextField(label: 'Add description',textController: descriptionController,),
              SizedBox(
                height: 16,
              ),
              DatePickerField(dueDateController: dueDateController),
              SizedBox(
                height: 8,
              ),
              Text(
                '  Priority',
                style: TextStyle(color: mutedTextColor),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: priorityList
                    .map((priority, value) => MapEntry(
                        priority,
                        SizedBox(
                            height: 35,
                            child: InkWell(
                                onTap: () {
                                  controller.selectedPriority = priority;
                                  priorityController =
                                      TextEditingController(text: priority);
                                },
                                child: PriorityTag(
                                  priorityObj: value,
                                  fontSize: 16,
                                  selected:
                                      controller.selectedPriority == priority
                                          ? true
                                          : false,
                                )))))
                    .values
                    .toList(),
              ),
              SizedBox(
                height: 16,
              ),
              CustomRoundRectButton(
                text: 'Create Task',
                height: 50,
                fontSize: 18,
                callBack: () {
                  taskController.addTask(TaskModel(
                      id :'1',
                      name :taskNameController?.text,
                      category:categoryController.text,
                      description: descriptionController?.text,
                      dueDate:dueDateController.text,
                      priority:priorityController.text
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
