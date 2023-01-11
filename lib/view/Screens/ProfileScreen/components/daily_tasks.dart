import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/check_date.dart';
import '../../../../constants/constants.dart';
import '../../../../providers/task_provider.dart';
import '../../../Common/task_tile.dart';

class DailyTasks extends StatelessWidget {
  const DailyTasks({Key? key}) : super(key: key);
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
          child: taskController.dueDateTaskMap.containsKey(convertDate(DateTime.now()))?ListView.builder(
            itemCount: taskController.dueDateTaskMap[convertDate(DateTime.now())]!.length,
            itemBuilder: (context, index) {
              return TaskTile(task: taskController.dueDateTaskMap[convertDate(DateTime.now())]![index],);
            },):Center(child: Text("No Tasks",style: TextStyle(color: Colors.white70,fontSize: 18),),),
        ),
      ),
    );
  }
}
