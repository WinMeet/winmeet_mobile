import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/utility/calendar/calendar_utils.dart';

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({super.key});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  CalendarFormat _calendarFormat = CalendarUtils.calendarFormat;
  DateTime _focusedDay = CalendarUtils.kToday;
  DateTime _selectedDay = CalendarUtils.kToday;
  @override
  Widget build(BuildContext context) {
    return TableCalendar<dynamic>(
      firstDay: CalendarUtils.kFirstDay,
      lastDay: CalendarUtils.kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      headerStyle: HeaderStyle(
        headerPadding: EdgeInsets.zero,
        titleCentered: true,
        titleTextStyle: context.theme.textTheme.headlineSmall!,
        formatButtonVisible: false,
      ),

      // Use `selectedDayPredicate` to determine which day is currently selected.
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() => _calendarFormat = format);
        }
      },
    );
  }
}
