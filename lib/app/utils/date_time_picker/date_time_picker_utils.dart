import 'package:flutter/material.dart';

import 'package:winmeet_mobile/app/utils/calendar/calendar_utils.dart';

class DateTimePickerUtils {
  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    required DateTime initialTime,
    String? datePickerHelpText,
    String? cancelText,
    String? confirmText,
    String? timePickerHelpText,
  }) async {
    final pickedDate = await _pickDate(
      context: context,
      initialTime: initialTime,
      helpText: datePickerHelpText,
      cancelText: cancelText,
      confirmText: confirmText,
    );

    if (context.mounted && pickedDate != null) {
      final pickedTime = await _pickTime(
        context: context,
        initialTime: initialTime,
        helpText: timePickerHelpText,
        cancelText: cancelText,
        confirmText: confirmText,
      );

      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }

  static Future<DateTime?> _pickDate({
    required BuildContext context,
    required DateTime initialTime,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialTime,
      firstDate: CalendarUtils.today,
      lastDate: CalendarUtils.lastDay,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
    );
  }

  static Future<TimeOfDay?> _pickTime({
    required BuildContext context,
    required DateTime initialTime,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialTime),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
    );
  }
}
