class CalendarUtils {
  static DateTime today = DateTime.now();
  static DateTime firstDay = DateTime.now().subtract(const Duration(days: 365));
  static DateTime lastDay = DateTime.now().add(const Duration(days: 365));

  static DateTime get initialStartDate {
    final currentTime = DateTime.now();

    return currentTime.add(Duration(minutes: 60 - currentTime.minute));
  }

  static DateTime get initialEndDate {
    final currentTime = DateTime.now();
    return currentTime.add(Duration(minutes: 120 - currentTime.minute));
  }
}
