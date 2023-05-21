import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:winmeet_mobile/app/widgets/indicators/custom_circular_progress_indicator.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.buttonText,
    required this.onPressed,
    required this.status,
    required this.isValid,
    super.key,
  });

  final String buttonText;
  final void Function()? onPressed;
  final FormzStatus status;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: status == FormzStatus.submissionInProgress || !isValid ? null : onPressed,
      child: status == FormzStatus.submissionInProgress ? const CustomCircularProgressIndicator() : Text(buttonText),
    );
  }
}
