import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Task title'),
                Text('3/10 subtask completed'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.calendar_month),
                    Text('3 days left'),
                    SizedBox(width: 10,),
                    Text('High')
                  ],
                ),
              ],
            ),
            Container(
              width: 100,
              height: 80,
              child: CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 10.0,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "70.0%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
