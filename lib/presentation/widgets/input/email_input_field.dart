import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    required this.textInputAction,
    required this.labelText,
    this.isValid,
    this.controller,
    this.onChanged,
    this.autoFocus,
    super.key,
  });

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final bool? autoFocus;
  final bool? isValid;
  final String labelText;

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      autofocus: autoFocus ?? false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        labelText: labelText,
        errorText: (isValid ?? false) ? 'Invalid email' : null,
      ),
      onChanged: onChanged,
    );
  }
}
