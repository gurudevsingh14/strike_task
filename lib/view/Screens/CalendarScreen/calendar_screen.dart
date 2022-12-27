import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/dateTime_controller.dart';
import 'package:strike_task/controller/table_calendar_controller.dart';
import 'package:strike_task/model/sub_task_model.dart';
import 'package:strike_task/providers/task_provider.dart';
import 'package:strike_task/view/Common/task_tile.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/task_model.dart';
import '../TaskDetailScreen/components/sub_task_tile.dart';

class CalendarScreen extends StatefulWidget {

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime,List<Task>>selectedTasks;
  @override
  void initState() {
    selectedTasks={DateTime.now():[]};
    super.initState();
  }
  List<Task> _getTasksOnSelectedDay(DateTime date) {
    return selectedTasks[date]??[];
  }
  @override
  Widget build(BuildContext context) {
    final taskDataController = Provider.of<TaskProvider>(context);
    final controller = Provider.of<TableCalendarController>(context);
    final dateTimeController = Provider.of<DateTimeController>(context);
    return Scaffold(
      body: Column(
        children: [
        TableCalendar(
          calendarFormat: controller.calendarFormat,
          focusedDay: controller.focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime(DateTime.now().year + 10),
          selectedDayPredicate: (day) {
            return isSameDay(controller.selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(controller.selectedDay, selectedDay)) {
              controller.selectedDay = selectedDay;
              controller.focusedDay = focusedDay;
              dateTimeController.selectedDate=focusedDay;
            }
            setState((){});
          },
          onFormatChanged: (format){
            if(controller.calendarFormat!=format)
            {
              controller.calendarFormat=format;
            }
          },
          onPageChanged: (focusedDay) {
            controller.focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
            rangeHighlightColor: primaryColor,
            selectedDecoration: BoxDecoration(color: primaryColor,shape: BoxShape.circle),
            todayDecoration: BoxDecoration(color: primaryColor.withOpacity(0.4),shape:  BoxShape.circle),
            outsideDaysVisible: false,
          ),
          headerStyle: HeaderStyle(
            // formatButtonVisible: true,
            formatButtonShowsNext: false,
            titleCentered: true,
          ),
          eventLoader: _getTasksOnSelectedDay,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
            decoration: BoxDecoration(
              color: primayLightColor.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
            ),
            child: taskDataController.taskList.length!=0?ListView(
            children: [
            ...taskDataController.getTaskOnSelectedDate(controller.selectedDay).map((e) => TaskTile(task: e,)),
            ],
            ):
            Column(
                children: [
                  Container(
                      height: 180,
                      alignment: Alignment.center,
                      child: Image.asset('assets/images/noTask.png',fit: BoxFit.cover,)),
                  SizedBox(height: 8,),
                  Text('Add Task',style: TextStyle(fontSize: 18,color: primayDarkColor,fontWeight: FontWeight.bold),)
                ]),
          ),
        ),
        ]
      ),
    );
  }
}
