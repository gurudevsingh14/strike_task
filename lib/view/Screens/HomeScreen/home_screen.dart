import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/model/task.dart';
import 'package:strike_task/view/Common/body_with_appbar.dart';
import 'package:strike_task/view/Common/task_tile.dart';
import 'package:strike_task/view/Common/catergory_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Task Categories',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w500,color: blackColor),),
          ),
          Container(
            width: displayWidth(context),
            height: displayHeight(context)*0.29,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext,index){
              return Column(
                children: [
                  CategoryCard(),
                ],
              );
            })
          ),
          Container(
            decoration: BoxDecoration(
              color: lightPrimaryColor.withOpacity(0.4),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            ),
            height: displayHeight(context)*0.6,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Tasks',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        TaskTile(),
                        TaskTile(),
                        TaskTile(),
                        TaskTile(),
                        TaskTile(),
                        TaskTile(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
