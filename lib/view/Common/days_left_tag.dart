import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:age_calculator/age_calculator.dart';

class DaysLeftTag extends StatelessWidget {
  Color? color=blackColor;
  DateTime? dueDate;
  DaysLeftTag({required this.color,this.dueDate});

  String? durationLeft(DateTime dueDate) {
    DateTime currDate=DateTime.now();
    DateDuration duration=AgeCalculator.dateDifference(fromDate: currDate, toDate: dueDate);
    int years=duration.years;
    int months=duration.months;
    int days=duration.days;
    if(years==0){
      if(months==0){
        if(days>=0)
        return days<=1?'$days day left':'$days days left';
        else
          return "passed due";
      } else if(months>0) {
        return months == 1 ? '$months month left' : '$months months left';
      } else{
        return "passed due";
      }
    }else if(years>0){
      return years==1?'$years year left':'$years years left';
    }else{
      return "passed due";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: primaryColor,
        border: Border.all(color: color!),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3),
        // width: 64,
        child: Text('${durationLeft(dueDate??DateTime.now())!}',maxLines: 2,style: TextStyle(fontSize: 12,color: color),)
    );
  }
}
