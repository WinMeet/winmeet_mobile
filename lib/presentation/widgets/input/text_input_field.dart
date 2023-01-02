import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.labelText,
    this.errorText,
    this.textInputAction,
    this.isValidInput,
    this.onChanged,
    this.validator,
  });

  final String labelText;
  final String? errorText;
  final TextInputAction? textInputAction;
  final bool? isValidInput;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        errorText: (isValidInput ?? true) ? null : errorText,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
