import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weli/generated/l10n.dart';

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

class SettingService {
  // Theme
  ThemeMode currentThemeMode = ThemeMode.system;

  // Language
  Locale currentLocate = window.locale;

  late SharedPreferences prefs;

  Future<SettingService> init() async {
    prefs = await SharedPreferences.getInstance();

    ///ThemeMode
    String themeModeCode = prefs.getString("themeModeCode") ?? ThemeMode.light.code;
    final themeMode = ThemeModeExtension.fromCode(themeModeCode);
    currentThemeMode = themeMode;

    ///Language
    String languageCode = prefs.getString("languageCode") ?? 'vi';
    var locale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == languageCode,
      orElse: () => const Locale.fromSubtags(languageCode: "en"),
    );
    currentLocate = locale;

    return this;
  }

  void changeThemeMode(ThemeMode themeMode) async {
    await prefs.setString('themeModeCode', themeMode.code);
    currentThemeMode = themeMode;
  }

  void updateLocale(Locale locale) async {
    var newLocale = S.delegate.supportedLocales.firstWhere(
      (element) => element.languageCode == locale.languageCode,
      orElse: () => const Locale.fromSubtags(languageCode: "en"),
    );
    await prefs.setString('languageCode', newLocale.languageCode);
    currentLocate = newLocale;
  }
}
