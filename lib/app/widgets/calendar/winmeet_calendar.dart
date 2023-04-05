import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:winmeet_mobile/app/theme/constants/theme_constants.dart';
import 'package:winmeet_mobile/app/utils/calendar/calendar_utils.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/core/utils/date_format/date_format_utils.dart';
import 'package:winmeet_mobile/feature/schedule/data/model/event_model.dart';

class WinMeetCalendar extends StatefulWidget {
  const WinMeetCalendar({
    required this.eventLoader,
    required this.onFocusedDayChanged,
    required this.focusedDay,
    super.key,
  });

  final List<EventModel> Function(DateTime) eventLoader;
  final void Function(DateTime) onFocusedDayChanged;
  final DateTime focusedDay;

  @override
  State<WinMeetCalendar> createState() => _WinMeetCalendarState();
}

class _WinMeetCalendarState extends State<WinMeetCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<dynamic>(
      focusedDay: _focusedDay,
      firstDay: CalendarUtils.firstDay,
      lastDay: CalendarUtils.lastDay,
      calendarFormat: _calendarFormat,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },

      // Styling
      calendarStyle: CalendarStyle(
        canMarkersOverflow: false,
        markersMaxCount: 1,

        defaultTextStyle: context.textTheme.bodyMedium!,
        weekendTextStyle: context.textTheme.bodyMedium!,
        todayTextStyle: context.textTheme.bodyMedium!,

        // Specify all of the decorations that you use because of the bug related with the package
        markerDecoration: BoxDecoration(
          color: context.theme.colorScheme.inversePrimary,
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
        selectedDecoration: BoxDecoration(
          color: context.theme.colorScheme.primary,
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
        todayDecoration: BoxDecoration(
          borderRadius: ThemeConstants.borderRadiusCircular,
          border: Border.all(
            color: context.theme.colorScheme.primary,
            width: 2,
          ),
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
        headerTitleBuilder: (context, date) {
          return AppBar(title: Text(DateFormatUtils.getMonthYear(date)));
        },
      ),

      selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_focusedDay, selectedDay)) {
          setState(() {
            _focusedDay = selectedDay;
          });
          widget.onFocusedDayChanged(selectedDay);
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) setState(() => _calendarFormat = format);
      },
      eventLoader: (day) => widget.eventLoader(day),
    );
  }
}
