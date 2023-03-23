import 'package:flutter/material.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';

class WinMeetHeading extends StatelessWidget {
  const WinMeetHeading({
    required this.text,
    this.textAlign,
    super.key,
  });

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: context.textTheme.headlineMedium!.copyWith(
        color: context.textTheme.headlineSmall!.color,
      ),
    );
  }
}
