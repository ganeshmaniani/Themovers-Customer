part of 'app_theme.dart';

@immutable
class _AppBarTheme {
  static const _appBarLightTheme = AppBarTheme(
    toolbarHeight: 50,
    backgroundColor: _GeneratorColors.red,
    titleTextStyle: TextStyle(color: _GeneratorColors.white),
    shadowColor: Colors.transparent,
    titleSpacing: 1,
    actionsIconTheme: IconThemeData(color: _GeneratorColors.lightGreen),
    iconTheme: IconThemeData(color: _GeneratorColors.white),
  );

  static const _appBarDarkTheme = AppBarTheme(
    toolbarHeight: 50,
    backgroundColor: Colors.green,
    titleTextStyle: TextStyle(color: _GeneratorColors.white),
    shadowColor: Colors.transparent,
    titleSpacing: 1,
    actionsIconTheme: IconThemeData(color: _GeneratorColors.white),
    centerTitle: true,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    foregroundColor: _GeneratorColors.white,
  );
}
