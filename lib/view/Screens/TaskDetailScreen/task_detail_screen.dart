import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/model/task.dart';
import 'package:strike_task/view/Common/priority_tag.dart';

import 'components/sub_task_tile.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor=Colors.grey.shade500;
    double indicatorRadius=50;
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Task detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Title',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,),),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('20-07-2022'),
                  PriorityTag(priorityObj: priorityList[0],)
                ],
              ),
              SizedBox(height: 12,),
              Text('Stats',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: textColor),),
              SizedBox(height: 12,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                    child: CircularPercentIndicator(
                      radius: indicatorRadius,
                      lineWidth: 9.0,
                      animation: true,
                      percent: 0.8,
                      center: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "70.0%",
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            Text('Done',style: TextStyle(color: textColor,fontSize: 12),)
                          ],
                        ),
                      ),
                      rotateLinearGradient: true,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.blue,
                    ),
                  ),
                  Container(
                    height: indicatorRadius*2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text('Completed',style: TextStyle(color: textColor),),
                            SizedBox(width: 8,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.green.shade300),
                              child: Text('12',style: TextStyle(color: whiteColor),),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Due Date Passed',style: TextStyle(color: textColor)),
                            SizedBox(width: 8,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.blue.shade300),
                              child: Text('12',style: TextStyle(color: whiteColor)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Pending',style: TextStyle(color: textColor)),
                            SizedBox(width: 8,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.yellow.shade300),
                              child: Text('12',style: TextStyle(color: whiteColor)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context)*0.05,
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: textColor),),
              SizedBox(height: 8,),
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              maxLines: 50,style: TextStyle(color: textColor),),
              SizedBox(height: 16,),
              Text('Sub Task',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: textColor),),
              SizedBox(height: 12,),
              SubTaskTile(),
              SubTaskTile(),
              SubTaskTile(),
              SubTaskTile(),
              SubTaskTile(),
            ],
          ),
        ),
      ),
    );
  }
}
