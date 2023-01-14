import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/check_date.dart';
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
  double calCompletePercentage(List<Task>taskList){
    List<Task>categoryTasks=taskList.where((task) => task.category==category).toList();
    int length=categoryTasks.length;
    if(length==0) return 0;
    double sumOfCompletePercentage=0;
    categoryTasks.forEach((task) {
      sumOfCompletePercentage+=task.completePercentage();
    });
    double avg=sumOfCompletePercentage/length;
    return avg;
  }
  @override
  Widget build(BuildContext context) {
    final categoryProvider=Provider.of<CategoryProvider>(context);
    final taskProvider=Provider.of<TaskProvider>(context);
    DateTime? getUpcomingTaskDueDate(String category){
      if(taskProvider.taskList.where((task) => task.category==category).toList().length==0) return null;
      List<Task>taskList=taskProvider.taskList.where((task) => task.category==category).toList();
      DateTime date=taskList[0].dueDate!;
      taskList.forEach((task) {
        if(compareDate(date, task.dueDate!)==1) date=task.dueDate!;
      });
      return date;
    }
    String? getUpcomingTaskDueDateString(String category){
      if(taskProvider.taskList.where((task) => task.category==category).toList().length==0) return null;
      DateTime date=getUpcomingTaskDueDate(category)!;
      List<String>months=["","jan","feb","march","april","may","june","july","aug","sept","dec"];
      return '${date.day} ${months[date.month]} ${date.year}';
    }
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
                  Text(getUpcomingTaskDueDateString(category!)??"No Tasks",style: TextStyle(color: whiteColor),),
                  Container(
                    height: 16,
                    width: 20,
                    child: PopupMenuButton<MenuItemModel>(
                      onSelected: (value) {
                        print("hii");
                      },
                      padding: EdgeInsets.zero,
                        icon: Icon(Icons.more_vert,size: 18,color: whiteColor,),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Row( children: [Icon(Icons.delete_outline),Text('delete')],),
                            onTap: () {
                              Future.delayed(
                                  Duration.zero,
                                      () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: Text('Deleting a Category will delete all Tasks of that Category',style: TextStyle(fontSize: 14),),
                                          actions: [
                                            TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel'),),
                                            TextButton(onPressed: ()async{
                                              await categoryProvider.deleteCategory(category!);
                                              await taskProvider.deleteAllTaskWithCategory(category!);
                                              Navigator.pop(context);}, child: Text('Delete'),)
                                          ],),
                                      )
                              );
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
                  Text(calCompletePercentage(taskProvider.taskList)==100?'Completed':'In Progress',style: TextStyle(color: whiteColor),),
                  Text('${calCompletePercentage(taskProvider.taskList).toStringAsFixed(1)}',style: TextStyle(color: whiteColor)),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,width: 0.4)
                ),
                child: LinearProgressIndicator(
                  value: calCompletePercentage(taskProvider.taskList)/100,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      child: Text('${taskProvider.taskList.where((task) => task.category==category&&task.isTaskCompleted()==true).toList().length}/'
                          '${taskProvider.taskList.where((task) => task.category==category).toList().length} done',maxLines: 1,style: TextStyle(color: whiteColor))
                  ),
                  getUpcomingTaskDueDate(category!)!=null?DaysLeftTag(color: whiteColor,dueDate: getUpcomingTaskDueDate(category!),):const SizedBox(),
                ],
              )
            ],
          ),
        )
    );
  }
}
