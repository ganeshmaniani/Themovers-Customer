import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'app_bar_theme.dart';
part 'color_scheme.dart';
part 'generator_colors.dart';
part 'text_theme.dart';

@immutable
class GeneratorTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _ColorScheme._lightColorScheme,
    textTheme: _TextTheme._textLightTheme,
    fontFamily: 'Roboto',
    appBarTheme: _AppBarTheme._appBarLightTheme,
    scaffoldBackgroundColor: _ColorScheme._lightColorScheme.background,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _ColorScheme._lightColorScheme,
    textTheme: _TextTheme._textLightTheme,
    fontFamily: 'Poppins',
    appBarTheme: _AppBarTheme._appBarLightTheme,
    scaffoldBackgroundColor: _ColorScheme._lightColorScheme.background,

    // brightness: Brightness.dark,
    // colorScheme: _ColorScheme._darkColorScheme,
    // textTheme: _TextTheme._textDarkTheme,
    // fontFamily: 'Roboto',
    // appBarTheme: _AppBarTheme._appBarDarkTheme,
    // scaffoldBackgroundColor: Colors.grey.shade900,
  );
}
