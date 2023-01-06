import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/menu_items.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/model/sub_task_model.dart';
import 'package:strike_task/view/Common/days_left_tag.dart';
import 'package:strike_task/view/Common/priority_tag.dart';
import 'package:strike_task/view/Common/percentage_indicator.dart';

import '../../constants/device_size.dart';
import '../../model/priority.dart';
import '../../model/task_model.dart';
import '../../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  Task? task;
  TaskTile({this.task});
  int subTaskDoneSize(Task task) {
    int count=0;
    task.subTaskList!.forEach((ele) {
      if(ele.done)count++;
    });
    return count;
  }
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth= FirebaseAuth.instance;
    final taskDataController=Provider.of<TaskProvider>(context);
    return InkWell(
      onTap: () {
        taskDataController.selectedTask=task!;
        Navigator.pushNamed(context, '/TaskDetail');
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Slidable(
          child: Card(
            margin: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: displayWidth(context)*0.65,
                        child: Text(
                          task!.name??'',
                          style: TextStyle(overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          task!.subTaskList==null? "no subtask added":
                          (subTaskDoneSize(task!)).toString()+"/"+(task!.subTaskList!.length).toString()+" subtask completed",
                        style: TextStyle(color: blackColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PriorityTag(
                              priorityObj: priorityList[task?.priority??"high"] ??
                                  priorityList['high']!),
                          SizedBox(
                            width: 10,
                          ),
                          DaysLeftTag(
                            color: mutedTextColor,
                            dueDate: task!.dueDate,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    // width: 100,
                    height: 80,
                    child: PercentageIndicator(
                      radius: 33.0,
                      lineWidth: 6.0,
                      percentage: task!.subTaskList==null?null:(subTaskDoneSize(task!))/(task!.subTaskList!.length),
                    ),
                  ),
                ],
              ),
            ),
          ),
          endActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                onPressed: (context) async{
                  if(task!.isArchived!){
                    await taskDataController.unArchiveTask(task!);
                  }
                  else{
                    await taskDataController.archiveTask(task!);
                  }

                },
                backgroundColor: Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.archive_outlined,
                label: task!.isArchived!?'Unarchive':'Archive',
              ),
              SlidableAction(
                onPressed: (context) {
                  taskDataController.deleteTask(auth.currentUser!.uid,task!);
                },
                backgroundColor: Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.delete_outline,
                label: 'Delete',
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}