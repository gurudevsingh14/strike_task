import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/providers/category_provider.dart';
import 'package:strike_task/providers/task_provider.dart';

import '../../../../constants/constants.dart';
import '../../../../model/task_model.dart';
import '../../../Common/task_tile.dart';

class CategoryTasksList extends StatelessWidget {
  const CategoryTasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController= Provider.of<TaskProvider>(context);
    final categoryController=Provider.of<CategoryProvider>(context);
    List<Task>taskList=taskController.taskList.where((task) => task.category==categoryController.selectedCategory).toList();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8,sigmaY: 8),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: primayLightColor.withOpacity(0.3)
          ),
          child: taskList.length!=0?ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return TaskTile(task: taskList[index],);
            },):Center(child: Text("No Tasks",style: TextStyle(color: Colors.white70,fontSize: 18),),),
        ),
      ),
    );;
  }
}
