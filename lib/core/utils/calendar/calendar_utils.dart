import 'package:table_calendar/table_calendar.dart';

class CalendarUtils {
  static DateTime kToday = DateTime.now();
  static DateTime kFirstDay = DateTime(kToday.year - 1, kToday.month, kToday.day);
  static DateTime kLastDay = DateTime(kToday.year + 1, kToday.month, kToday.day);
  static CalendarFormat calendarFormat = CalendarFormat.week;
}

class CalendarUtils2 {
  static DateTime today = DateTime.now();
  static DateTime firstDay = DateTime.now().subtract(const Duration(days: 365));
  static DateTime lastDay = DateTime.now().add(const Duration(days: 365));
}
