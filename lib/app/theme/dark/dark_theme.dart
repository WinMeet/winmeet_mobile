import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/theme/base/base_theme.dart';

@lazySingleton
class DarkTheme extends BaseTheme {
  @override
  Brightness get brightness => Brightness.dark;
}
