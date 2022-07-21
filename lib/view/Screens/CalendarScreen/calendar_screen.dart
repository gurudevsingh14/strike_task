import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/constants.dart';
import 'package:strike_task/controller/table_calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TableCalendarController>(context);
    return Center(
      child: TableCalendar(
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
      ),
    );
  }
}
