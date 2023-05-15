import 'package:flutter/material.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';

abstract class SnackbarUtils {
  static void showSnackbar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: context.durationVeryHigh,
          content: Text(message),
        ),
      );
  }
}
