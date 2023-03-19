import 'package:flutter/material.dart';
import 'package:winmeet_mobile/app/theme/constants/theme_constants.dart';

abstract class BaseTheme {
  ColorScheme get colorScheme;

  ThemeData get theme {
    return ThemeData.from(
      colorScheme: colorScheme,
    ).copyWith(
      useMaterial3: true,
      elevatedButtonTheme: _elevatedButtonTheme,
      floatingActionButtonTheme: _floatingActionTheme,
      inputDecorationTheme: _inputDecorationTheme,
      typography: Typography.material2021(),
    );
  }

  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      ),
    );
  }

  FloatingActionButtonThemeData get _floatingActionTheme {
    return FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: ThemeConstants.borderRadiusCircular,
      ),
    );
  }

  InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: ThemeConstants.borderRadiusCircular,
      ),
    );
  }
}
