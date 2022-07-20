import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:strike_task/constants/constants.dart';
import '../../model/priority.dart';

class PriorityTag extends StatelessWidget {
    PriorityModel priorityObj;
    bool selected;
    double? fontSize;
    PriorityTag({ required this.priorityObj,this.fontSize,this.selected=false});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected?priorityObj.color:priorityObj.bgColor!,
          border: Border.all(color: priorityObj.color!),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 16),
        child: Text(priorityObj.label!,maxLines: 1,style: TextStyle(fontSize: fontSize??12,color: selected?whiteColor:priorityObj.color!),)
    );
  }
}
