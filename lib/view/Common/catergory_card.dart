import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/model/task_model.dart';
import 'package:strike_task/providers/category_provider.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/view/Common/days_left_tag.dart';

import '../../constants/menu_items.dart';
import '../../model/menu_item_model.dart';

class CategoryCard extends StatelessWidget {
  String? category;
  CategoryCard({this.category});
  @override
  Widget build(BuildContext context) {
    final categoryProvider=Provider.of<CategoryProvider>(context);
    final taskProvider=Provider.of<TaskProvider>(context);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('12 june 2020',style: TextStyle(color: whiteColor),),
                  Container(
                    height: 16,
                    width: 20,
                    child: PopupMenuButton<MenuItemModel>(
                      padding: EdgeInsets.zero,
                        icon: Icon(Icons.more_vert,size: 18,color: whiteColor,),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Row( children: [Icon(Icons.delete_outline),Text('delete')],),
                            onTap: () async {
                              await categoryProvider.deleteCategory(category!);
                            },
                          )
                        ],
                        // itemBuilder: (context) => [
                        //   ...menuItems.map((e) => PopupMenuItem(
                        //       onTap: () async {
                        //         categoryProvider.deleteCategory(category!);
                        //       },
                        //       child: Row(children: [e.icon!,e.text!],)))
                        // ]),
                    )
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text(category??'Task Category',maxLines:2,overflow:TextOverflow.ellipsis,style: TextStyle( color: whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize:30),),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('In Progress',style: TextStyle(color: whiteColor),),
                  Text('${(((taskProvider.taskList.where((task) => task.category==category&&task.isTaskCompleted()).toList().length)/(taskProvider.taskList.length))*100).toStringAsFixed(1)}',style: TextStyle(color: whiteColor)),
                ],
              ),
              SizedBox(height: 5,),
              LinearProgressIndicator(
                value: ((taskProvider.taskList.where((task) => task.category==category&&task.isTaskCompleted()).toList().length)/((taskProvider.taskList.length)==0?1:(taskProvider.taskList.length))),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(

                      child: Text('3/4 completed',maxLines: 1,style: TextStyle(color: whiteColor))
                  ),
                  DaysLeftTag(color: whiteColor),
                ],
              )
            ],
          ),
        )
    );
  }
}
