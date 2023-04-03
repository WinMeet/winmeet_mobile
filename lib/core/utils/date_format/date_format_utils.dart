import 'package:intl/intl.dart';

abstract class DateFormatUtils {
  /// Returns the date time as the following format: April 2023
  static String getMonthYear(DateTime date) => DateFormat('MMMM yyyy').format(date.toLocal());

  /// Returns the date time as the following format: Apr 3, 2023 10:00 PM
  static String getMonthDayYearHour(DateTime date) => DateFormat.yMMMd().add_jm().format(date.toLocal());

  /// Returns the date time as the following format: Thursday, April 13
  static String getDayMonthDay(DateTime date) => DateFormat('EEEE, MMMM d').format(date.toLocal());

  /// Returns the date time as the following format: 4:00 AM
  static String get12HourFormat(DateTime date) => DateFormat('h:mm a').format(date.toLocal());
}
