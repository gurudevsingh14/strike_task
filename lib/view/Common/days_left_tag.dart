import 'package:flutter/material.dart';
import 'package:strike_task/constants/constants.dart';

class DaysLeftTag extends StatelessWidget {
  Color? color=blackColor;
  DaysLeftTag({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: primaryColor,
        border: Border.all(color: color!),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 3),
        width: 64,
        child: Text('3 days left',maxLines: 2,style: TextStyle(fontSize: 12,color: color),)
    );
  }
}
