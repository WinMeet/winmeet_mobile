import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.onChanged,
    required this.hintText,
    super.key,
  });

  final void Function(String)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      cursorColor: Theme.of(context).focusColor,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
