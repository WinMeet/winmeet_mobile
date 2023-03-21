import 'package:flutter/material.dart';

class NormalInputField extends StatelessWidget {
  const NormalInputField({
    required this.labelText,
    required this.textInputAction,
    this.isValid,
    this.errorLabel,
    this.prefixIcon,
    super.key,
    this.onChanged,
  });
  final Icon? prefixIcon;
  final String labelText;
  final String? errorLabel;
  final TextInputAction textInputAction;
  final bool? isValid;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        errorText: (isValid ?? true) ? null : errorLabel,
      ),
      onChanged: onChanged,
    );
  }
}
