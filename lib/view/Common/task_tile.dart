import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/view/Common/days_left_tag.dart';
import 'package:strike_task/view/Common/priority_tag.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/TaskDetail');
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Task title',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                  SizedBox(height: 8,),
                  Text('3/10 subtask completed',style: TextStyle(color: blackColor),),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PriorityTag(priorityObj: priorityList[0],),
                      SizedBox(width: 10,),
                      DaysLeftTag(color: mutedTextColor,),
                    ],
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 80,
                child: CircularPercentIndicator(
                  radius: 33.0,
                  lineWidth: 8.0,
                  animation: true,
                  percent: 0.8,
                  center: new Text(
                    "70.0%",
                    style:
                    new TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                  ),
                  rotateLinearGradient: true,
                  // linearGradient: LinearGradient(
                  //   colors: [Colors.red,Colors.orange,Colors.yellow,Colors.lightBlue,Colors.lightGreen,Colors.green],
                  //   stops: [0.1,0.3,0.5,0.7,0.8,1],
                  // ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
