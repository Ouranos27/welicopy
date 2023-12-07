import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weli/service/service_app/setting_service.dart';

import '../../../main.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final settingService = getIt<SettingService>();

  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeEvent>((event, emit) {
      if (event is InitSetting) {
        emit(ThemeDataState(currentThemeMode: settingService.currentThemeMode, currentLocale: settingService.currentLocate));
      }
      if (event is ChangeTheme) {
        /// save db
        settingService.changeThemeMode(event.themeMode);
        emit(ThemeDataState(currentThemeMode: event.themeMode, currentLocale: settingService.currentLocate));
      }
      if (event is ChangeLocale) {
        /// save db
        settingService.updateLocale(event.currentLocate);
        emit(ThemeDataState(currentThemeMode: settingService.currentThemeMode, currentLocale: event.currentLocate));
      }
    });
  }
}

extension ThemeModeExtension on ThemeMode {
  String get code {
    switch (this) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  static ThemeMode fromCode(String code) {
    switch (code) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
