import 'package:flutter/material.dart';
import 'package:winmeet_mobile/app/theme/constants/theme_constants.dart';

abstract class BaseTheme {
  Brightness get brightness;

  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      appBarTheme: _appBarTheme,
      dialogTheme: _dialogTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      floatingActionButtonTheme: _floatingActionTheme,
      inputDecorationTheme: _inputDecorationTheme,
      typography: Typography.material2021(),
    );
  }

  AppBarTheme get _appBarTheme => const AppBarTheme(
        centerTitle: true,
      );

  DialogTheme get _dialogTheme => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      );

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: ThemeConstants.borderRadiusCircular,
          ),
        ),
      );

  FloatingActionButtonThemeData get _floatingActionTheme => FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      );
}
