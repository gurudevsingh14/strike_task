import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../providers/task_provider.dart';
import '../../../Common/task_tile.dart';

class StarredTasks extends StatelessWidget {
  const StarredTasks({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController=Provider.of<TaskProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8,sigmaY: 8),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: primayLightColor.withOpacity(0.3)
          ),
          child: taskController.taskList.where((element) => element.isStarred!).toList().length!=0?ListView.builder(
            itemCount: taskController.taskList.where((element) => element.isStarred!).toList().length,
            itemBuilder: (context, index) {
              return TaskTile(task: taskController.taskList.where((element) => element.isStarred!).toList().elementAt(index),);
            },):Center(child: Text("No Tasks",style: TextStyle(color: Colors.white70,fontSize: 18),),),
        ),
      ),
    );
  }
}
