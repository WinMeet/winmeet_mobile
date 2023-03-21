import 'package:flutter/material.dart';
import 'package:winmeet_mobile/core/utils/calendar/calendar_utils.dart';

class DateTimePickerUtils {
  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    required DateTime initialTime,
  }) async {
    final pickedDate = await _pickDate(context: context, initialTime: initialTime);

    if (context.mounted && pickedDate != null) {
      final pickedTime = await _pickTime(context: context, initialTime: initialTime);

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

  static Future<DateTime?> _pickDate({required BuildContext context, required DateTime initialTime}) {
    return showDatePicker(
      context: context,
      initialDate: initialTime,
      firstDate: CalendarUtils.today,
      lastDate: CalendarUtils.lastDay,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'Select Meeting Date',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );
  }

  static Future<TimeOfDay?> _pickTime({required BuildContext context, required DateTime initialTime}) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialTime),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      helpText: 'Select Meeting Time',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
    );
  }
}
