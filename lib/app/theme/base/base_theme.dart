import 'package:flutter/material.dart';
import 'package:winmeet_mobile/app/theme/constants/theme_constants.dart';

abstract class BaseTheme {
  Brightness get brightness;

  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      appBarTheme: _appBarTheme,
      bottomSheetTheme: _bottomSheetTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      dividerTheme: _dividerTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      expansionTileTheme: _expansionTileThemeData,
      floatingActionButtonTheme: _floatingActionTheme,
      listTileTheme: _listTileTheme,
      inputDecorationTheme: _inputDecorationTheme,
      typography: Typography.material2021(),
    );
  }

  AppBarTheme get _appBarTheme => const AppBarTheme(
        centerTitle: true,
      );

  BottomSheetThemeData get _bottomSheetTheme => BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: ThemeConstants.radiusCircular,
            topRight: ThemeConstants.radiusCircular,
          ),
        ),
      );

  CardTheme get _cardTheme => CardTheme(
        elevation: 4,
        margin: EdgeInsets.zero,
        shape: OutlineInputBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      );

  DialogTheme get _dialogTheme => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      );

  DividerThemeData get _dividerTheme => const DividerThemeData(
        thickness: 4,
      );

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: ThemeConstants.borderRadiusCircular,
          ),
        ),
      );

  ExpansionTileThemeData get _expansionTileThemeData => const ExpansionTileThemeData(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
      );

  FloatingActionButtonThemeData get _floatingActionTheme => FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      );

  ListTileThemeData get _listTileTheme => const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
      );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: ThemeConstants.borderRadiusCircular,
        ),
      );
}
