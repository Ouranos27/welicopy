import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weli/page/theme/bloc/theme_bloc.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';

import '../../main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final settingService = getIt<SettingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<ThemeBloc>(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is ThemeDataState) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildThemeSection(state),
                    _buildLanguageSection(state),
                    ElevatedButton(
                      onPressed: () {
                        final authService = getIt<AuthService>();
                        authService.removeToken();
                        Navigator.pushNamedAndRemoveUntil(context, RouteDefine.login.name, ModalRoute.withName(RouteDefine.login.name));
                      },
                      child: const Text('logout'),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildThemeSection(ThemeDataState state) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "theme Mode",
          style: theme.textTheme.headline6,
        ),
        RadioListTile(
          title: const Text('settings_themeModeSystem'),
          value: ThemeMode.system,
          groupValue: state.currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              context.read<ThemeBloc>().add(ChangeTheme(value));
            }
          },
        ),
        RadioListTile(
          title: const Text('settings_themeModeLight'),
          value: ThemeMode.light,
          groupValue: state.currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              context.read<ThemeBloc>().add(ChangeTheme(value));
            }
          },
        ),
        RadioListTile(
          title: const Text('settings_themeModeDark'),
          value: ThemeMode.dark,
          groupValue: state.currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              context.read<ThemeBloc>().add(ChangeTheme(value));
            }
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSection(ThemeDataState state) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings_language',
          style: theme.textTheme.headline6,
        ),
        RadioListTile(
          title: const Text('settings_languageEnglish'),
          value: const Locale.fromSubtags(languageCode: 'en'),
          groupValue: settingService.currentLocate,
          onChanged: (Locale? value) {
            if (value != null) {
              context.read<ThemeBloc>().add(ChangeLocale(value));
            }
          },
        ),
        RadioListTile(
          title: const Text('settings_languageFrench'),
          value: const Locale.fromSubtags(languageCode: 'fr'),
          groupValue: settingService.currentLocate,
          onChanged: (Locale? value) {
            if (value != null) {
              context.read<ThemeBloc>().add(ChangeLocale(value));
            }
          },
        ),
      ],
    );
  }
}
