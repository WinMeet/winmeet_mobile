import 'package:flutter/material.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';

class WinMeetTitleMedium extends StatelessWidget {
  const WinMeetTitleMedium({
    required this.text,
    super.key,
    this.textAlign,
  });

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.textTheme.titleMedium,
    );
  }
}
