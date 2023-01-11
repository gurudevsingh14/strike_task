import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/constants/device_size.dart';
import 'package:strike_task/constants/priority.dart';
import 'package:strike_task/model/priority.dart';
import 'package:strike_task/view/Common/priority_tag.dart';
import 'package:timelines/timelines.dart';

import '../../../model/sub_task_model.dart';
import '../../../model/task_model.dart';
import '../../../providers/task_provider.dart';


const kTileHeight = 50.0;

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider= Provider.of<TaskProvider>(context);
    return Scaffold(
      body: taskProvider.dueDateTaskMap.length!=0?ListView.builder(
        itemCount: taskProvider.dueDateTaskMap.length,
        itemBuilder: (context, index) {
          List<Task> data = taskProvider.dueDateTaskMap.values.elementAt(index);
          DateTime date=taskProvider.dueDateTaskMap.keys.elementAt(index);
          return Center(
            child: Container(
              width: 360.0,
              child: Card(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          '${date.day}/${date.month}/${date.year}',
                        style: TextStyle(
                          color: Color(0xffb6b2b2),
                        ),
                      )
                    ),
                    Divider(height: 1.0),
                    TaskProcesses(processes: data),
                  ],
                ),
              ),
            ),
          );
        },
      ):Center(child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
        Text("No Pending Tasks",style: TextStyle(color: primaryColor,fontSize: 18),),
        Image.asset('assets/images/completed.png',)
      ],),),
    );
  }
}

class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.subTasks,
  });

  final List<SubTask> subTasks;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == subTasks.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
            thickness: 1.0,
          ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
            size: 12.0,
            position: 0.5,
          ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
          !isEdgeIndex(index) ? (subTasks[index-1].done==true?DotIndicator(
            color: Color(0xff66c97f),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 12.0,
            ),
          ):Indicator.outlined(borderWidth: 1.5) ): null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(subTasks[index - 1].name??'',overflow: TextOverflow.ellipsis,maxLines: 4,),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 12.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
          isEdgeIndex(index) ? true : null,
          itemCount: subTasks.length + 2,
        ),
      ),
    );
  }
}

class TaskProcesses extends StatelessWidget {
  const TaskProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<Task> processes;
  @override
  Widget build(BuildContext context) {
    final taskProvider= Provider.of<TaskProvider>(context);
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: Color(0xff989898),
            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,
            contentsBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            width: displayWidth(context)*0.4,
                            child: Text(processes[index].name??'',overflow: TextOverflow.ellipsis,maxLines: 3,style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 18.0,
                            ),),
                          ),
                          onTap: () {
                            taskProvider.selectedTask=processes[index];
                            Navigator.pushNamed(context, '/TaskDetail');
                          },
                        ),
                        Spacer(),
                        PriorityTag(priorityObj: priorityList[processes[index]?.priority??"high"] ??
                            priorityList['high']!)
                      ],
                    ),
                    processes[index].subTaskList!=null?_InnerTimeline(subTasks: processes[index].subTaskList!):SizedBox(),
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (processes[index].isTaskCompleted()) {
                return DotIndicator(
                  color: Color(0xff66c97f),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                return OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: null,
            ),
          ),
        ),
      ),
    );
  }
}

