
import 'package:flutter/material.dart';

class DateTimePickerUtils {
  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    required DateTime initialTime,
    required DateTime firstDate,
    required DateTime lastDate,
    String? datePickerHelpText,
    String? cancelText,
    String? confirmText,
    String? timePickerHelpText,
  }) async {
    final pickedDate = await _pickDate(
      context: context,
      initialTime: initialTime,
      firstDate: firstDate,
      lastDate: lastDate,
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
    required DateTime firstDate,
    required DateTime lastDate,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialTime,
      firstDate: firstDate,
      lastDate: lastDate,
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
