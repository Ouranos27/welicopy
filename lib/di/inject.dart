import 'package:weli/main.dart';
import 'package:weli/page/main/bloc/main_bloc.dart';
import 'package:weli/page/theme/bloc/theme_bloc.dart';
import 'package:weli/service/service_app/service.dart';

Future<void> setupGetIt() async {
  var notificationService = await NotificationService().init();
  getIt.registerSingleton<NotificationService>(notificationService);

  var authService = await AuthService().init();
  getIt.registerSingleton<AuthService>(authService);

  var customFunctionService = CustomFunctionService.init();
  getIt.registerSingleton<CustomFunctionService>(customFunctionService);

  var settingService = await SettingService().init();
  getIt.registerSingleton<SettingService>(settingService);

  var mainBloc = MainBloc();
  getIt.registerSingleton<MainBloc>(mainBloc);

  var themeBloc = ThemeBloc();
  getIt.registerSingleton<ThemeBloc>(themeBloc);
}
