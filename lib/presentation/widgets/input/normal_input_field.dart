import 'package:flutter/material.dart';

class NormalInputField extends StatelessWidget {
  const NormalInputField({
    required this.labelText,
    required this.errorLabel,
    required this.textInputAction,
    required this.isValid,
    super.key,
    this.onChanged,
  });

  final String labelText;
  final String errorLabel;
  final TextInputAction textInputAction;
  final bool isValid;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
        labelText: labelText,
        errorText: isValid ? errorLabel : null,
      ),
      onChanged: onChanged,
    );
  }
}
