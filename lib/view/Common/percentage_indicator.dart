import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageIndicator extends StatelessWidget {
    double? lineWidth;
    double? percentage;
    double? radius;
    PercentageIndicator({this.lineWidth,this.percentage,this.radius});
  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.grey.shade500;
    return CircularPercentIndicator(
      radius: radius??12.0,
      lineWidth: lineWidth??8.0,
      animation: true,
      percent: percentage??0,
      center: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ((percentage??0)*100).toStringAsFixed(0)+" %",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            // Text(
            //   'Done',
            //   style: TextStyle(color: textColor, fontSize: 12),
            // )
          ],
        ),
      ),
      rotateLinearGradient: true,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.blue,
    );
  }
}
