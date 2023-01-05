import 'dart:developer';
import 'package:timelines/timelines.dart';
import 'package:flutter/material.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Timeline.tileBuilder(
        builder: TimelineTileBuilder.fromStyle(
          nodePositionBuilder: (context, index) {
            return 0;
          },
          contentsAlign: ContentsAlign.basic,
          contentsBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text('Timeline Event $index'),
          ),
          itemCount: 10,
        ),
      )
    );
  }
}
