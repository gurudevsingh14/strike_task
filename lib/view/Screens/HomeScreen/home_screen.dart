import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/view/Common/body_with_appbar.dart';
import 'package:strike_task/view/Common/task_tile.dart';
import 'package:strike_task/view/Common/catergory_card.dart';

class HomeScreen extends StatelessWidget {
  String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp("(\\.\\d{6})\\d+"), (m) => m[1]!);

  @override
  Widget build(BuildContext context) {
    final taskDataController = Provider.of<TaskProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey Gurudev',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primayDarkColor),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text('lets be productive today')
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/dp.jpg'),
                ),
              )
            ],
          ),
        ),
        Container(
            width: displayWidth(context),
            height: displayHeight(context) * 0.29,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext, index) {
                  return Column(
                    children: [
                      CategoryCard(),
                    ],
                  );
                })),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                color: primayLightColor.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '  Tasks',
                          style: TextStyle(fontSize: 18,color: primayDarkColor,fontWeight: FontWeight.bold),
                      ),
                    ),
                    taskDataController.taskList.length!=0?Expanded(
                      child: ListView.builder(
                        itemCount: taskDataController.taskList.length,
                        itemBuilder: (context, index) => TaskTile(
                          task: taskDataController.taskList[index],
                        ),
                      ),
                    ):
                    Column(
                      children: [
                        Container(
                        height: 180,
                          alignment: Alignment.center,
                          child: Image.asset('assets/images/noTask.png',fit: BoxFit.cover,)),
                        SizedBox(height: 8,),
                        Text('Add Task',style: TextStyle(fontSize: 18,color: primayDarkColor,fontWeight: FontWeight.bold),)
                    ]),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
