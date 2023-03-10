import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppTheme {
  final ThemeData lightTheme = ThemeData.from(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6200ee),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbb86fc),
      onPrimaryContainer: Color(0xff100c14),
      secondary: Color(0xff03dac6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcefaf8),
      onSecondaryContainer: Color(0xff111414),
      tertiary: Color(0xff018786),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa4f1ef),
      onTertiaryContainer: Color(0xff0e1414),
      error: Color(0xffb00020),
      onError: Color(0xffffffff),
      errorContainer: Color(0xfffcd8df),
      onErrorContainer: Color(0xff141213),
      background: Color(0xfff9f6fe),
      onBackground: Color(0xff090909),
      surface: Color(0xfff9f6fe),
      onSurface: Color(0xff090909),
      surfaceVariant: Color(0xfff3edfd),
      onSurfaceVariant: Color(0xff131213),
      outline: Color(0xff565656),
      shadow: Color(0xff000000),
      inverseSurface: Color(0xff131018),
      onInverseSurface: Color(0xfff5f5f5),
      inversePrimary: Color(0xffda99ff),
      surfaceTint: Color(0xff6200ee),
    ),
  ).copyWith(typography: Typography.material2021());

  final ThemeData darkTheme = ThemeData.from(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb39ddb),
      onPrimary: Color(0xff121014),
      primaryContainer: Color(0xff7e57c2),
      onPrimaryContainer: Color(0xfff3edfe),
      secondary: Color(0xff80d8ff),
      onSecondary: Color(0xff0e1414),
      secondaryContainer: Color(0xff00497b),
      onSecondaryContainer: Color(0xffdfebf3),
      tertiary: Color(0xff40c4ff),
      onTertiary: Color(0xff091314),
      tertiaryContainer: Color(0xff0179b6),
      onTertiaryContainer: Color(0xffdff2fc),
      error: Color(0xffcf6679),
      onError: Color(0xff140c0d),
      errorContainer: Color(0xffb1384e),
      onErrorContainer: Color(0xfffbe8ec),
      background: Color(0xff1a191c),
      onBackground: Color(0xffedeced),
      surface: Color(0xff1a191c),
      onSurface: Color(0xffedeced),
      surfaceVariant: Color(0xff242128),
      onSurfaceVariant: Color(0xffdcdcdd),
      outline: Color(0xffa39da3),
      shadow: Color(0xff000000),
      inverseSurface: Color(0xfffaf9fc),
      onInverseSurface: Color(0xff131313),
      inversePrimary: Color(0xff5c536d),
      surfaceTint: Color(0xffb39ddb),
    ),
  ).copyWith(typography: Typography.material2021());
}
