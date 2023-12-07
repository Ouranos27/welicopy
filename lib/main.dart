import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/firebase_options.dart';
import 'package:weli/service/service_app/service.dart';

import 'config/theme.dart';
import 'di/inject.dart';
import 'generated/l10n.dart';
import 'page/theme/bloc/theme_bloc.dart';
import 'util/route/app_routing.dart';

GetIt getIt = GetIt.instance;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Is a smart move to make your Services intiialize before you run the Flutter app.
  /// as you can control the execution flow (maybe you need to load some Theme configuration,
  /// apiKey, language defined by the User... so load SettingService before running ApiService.
  /// setup Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Crashlytics.init();
  await setupGetIt();

  HttpOverrides.global = MyHttpOverrides();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeBloc>()..add(InitSetting()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          var themeMode = ThemeMode.dark;
          // var currentLocale = const Locale.fromSubtags(languageCode: 'fr');
          Locale currentLocale = window.locale;
          print(currentLocale);

          if (state is ThemeDataState) {
            themeMode = state.currentThemeMode;
            currentLocale = state.currentLocale;
          }

          return GestureDetector(
            onTap: hideKeyboard,
            child: Sizer(
              builder: (context, orientation, deviceType) => MaterialApp(
                navigatorKey: AppRouting.mainNavigationKey,
                builder: EasyLoading.init(),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  FormBuilderLocalizations.delegate,
                  RefreshLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: currentLocale,
                title: 'Weli',
                onGenerateRoute: AppRouting.generateMainRoute,
                initialRoute: RouteDefine.splash.name,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
              ),
            ),
          );
        },
      ),
    );
  }

  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
