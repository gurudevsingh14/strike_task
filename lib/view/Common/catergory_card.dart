import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/model/task.dart';
import 'package:strike_task/view/Common/days_left_tag.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
        child: Container(
          height: displayHeight(context)*0.265,
          width: displayWidth(context)*0.47,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColor,primayLightColor,Color(0xFB6DE1A7)],
              stops: [0.5,0.8,1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('12 june 2020',style: TextStyle(color: whiteColor),),
                  Icon(Icons.more_vert,size: 16,color: whiteColor,)
                ],
              ),
              SizedBox(height: 20,),
              Text('Task Category',style: TextStyle( color: whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize:30),),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('In Progress',style: TextStyle(color: whiteColor),),
                  Text('70%',style: TextStyle(color: whiteColor)),
                ],
              ),
              SizedBox(height: 5,),
              LinearProgressIndicator(
                value: 0.7,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(

                      child: Text('3/4 completed',maxLines: 1,style: TextStyle(color: whiteColor))
                  ),
                  DaysLeftTag(color: whiteColor,),
                ],
              )
            ],
          ),
        )
    );
  }
}
