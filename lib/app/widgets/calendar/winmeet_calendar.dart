import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:winmeet_mobile/app/theme/constants/theme_constants.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';

import 'package:winmeet_mobile/core/utils/calendar/calendar_utils.dart';

class WinMeetCalendar extends StatefulWidget {
  const WinMeetCalendar({super.key});

  @override
  State<WinMeetCalendar> createState() => _WinMeetCalendarState();
}

class _WinMeetCalendarState extends State<WinMeetCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = CalendarUtils2.today;

  @override
  Widget build(BuildContext context) {
    return TableCalendar<dynamic>(
      focusedDay: _focusedDay,
      firstDay: CalendarUtils2.firstDay,
      lastDay: CalendarUtils2.lastDay,
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      // Styling
      calendarStyle: CalendarStyle(
        canMarkersOverflow: false,
        tablePadding: context.paddingAllLow,

        defaultTextStyle: context.textTheme.bodyMedium!,
        weekendTextStyle: context.textTheme.bodyMedium!,
        todayTextStyle: context.textTheme.bodyMedium!,

        // Specify all of the decorations that you use because of the bug related with the package
        selectedDecoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
        todayDecoration: BoxDecoration(
          color: context.theme.disabledColor,
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
        weekendDecoration: BoxDecoration(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
        defaultDecoration: BoxDecoration(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
        outsideDecoration: BoxDecoration(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      ),
      headerStyle: HeaderStyle(
        headerPadding: EdgeInsets.zero,
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: context.theme.textTheme.headlineSmall!,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: context.textTheme.bodyMedium!,
        weekendStyle: context.textTheme.bodyMedium!,
      ),

      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          final monthName = DateFormat('MMMM').format(day);
          final year = DateFormat('y').format(day);
          return AppBar(title: Text('$monthName $year'));
        },
      ),

      selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_focusedDay, selectedDay)) setState(() => _focusedDay = selectedDay);
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) setState(() => _calendarFormat = format);
      },
      eventLoader: (day) {
        return <dynamic>[];
      },
    );
  }
}
