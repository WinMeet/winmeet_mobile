import 'package:flutter/material.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    required this.isSelected,
    super.key,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.lowValue,
      decoration: BoxDecoration(
        color: isSelected ? context.theme.primaryColor : context.theme.disabledColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
