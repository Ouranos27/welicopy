part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class InitSetting extends ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final ThemeMode themeMode;

  ChangeTheme(this.themeMode);
}

class ChangeLocale extends ThemeEvent {
  final Locale currentLocate;

  ChangeLocale(this.currentLocate);
}
