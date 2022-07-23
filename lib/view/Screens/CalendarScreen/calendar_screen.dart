import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/table_calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/task_model.dart';
import '../TaskDetailScreen/components/sub_task_tile.dart';

class CalendarScreen extends StatefulWidget {

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime,List<TaskModel>>selectedTasks;

  @override
  void initState() {
    selectedTasks={DateTime.now():[]};
    super.initState();
  }
  List<TaskModel> _getTasksOnSelectedDay(DateTime date) {
    return selectedTasks[date]??[];
  }
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TableCalendarController>(context);
    return Column(
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
        ..._getTasksOnSelectedDay(DateTime.now()).map((value) => Column(children: [SubTaskTile(),SubTaskTile()],)).toList()
      ]
    );
  }
}
