import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.deepPurple,
      );

  ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.deepPurple,
      );
}
