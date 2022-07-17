import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/model/task.dart';

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
          height: displayHeight(context)*0.26,
          width: displayWidth(context)*0.48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('12 june 2020'),
                  Icon(Icons.more_vert,size: 16,)
                ],
              ),
              SizedBox(height: 20,),
              Text('Task Category',style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize:30),),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('In Progress'),
                  Text('70%'),
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

                      child: Text('3/4 completed',maxLines: 1)
                  ),
                  Card(
                    elevation: 2,
                    child: SizedBox(
                        width: 60,
                        child: Text('3 days left',maxLines: 2,style: TextStyle(fontSize: 12),)
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
