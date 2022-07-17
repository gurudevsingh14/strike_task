import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
          Text('Task Categories',style: TextStyle(fontSize: 24),),
          SizedBox(
            width: displayWidth(context),
            height: displayHeight(context)*0.3,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext,index){
              return Column(
                children: [
                  CategoryCard(),
                  SizedBox(height: 20,)
                ],
              );
            })
          ),
          Text('Tasks'),
          Container(
            height: displayHeight(context)*0.6,
            child: ListView(
              children: [
                TaskTile(),
                TaskTile(),
                TaskTile(),
                TaskTile(),
                TaskTile(),
                TaskTile(),
              ],
            )
          )
        ],
      ),
    );
  }
}
