part of 'theme_bloc.dart';

@immutable
abstract class ThemeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeDataState extends ThemeState {
  final ThemeMode currentThemeMode;

  final Locale currentLocale;

  ThemeDataState({required this.currentThemeMode, required this.currentLocale});

  @override
  List<Object> get props => [currentThemeMode, currentLocale];
}
