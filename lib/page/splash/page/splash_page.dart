import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/page/splash/bloc/splash_bloc.dart';
import 'package:weli/util/route/app_routing.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SplashBloc()..add(InitStart()),
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, RouteDefine.main.name);
            }
            if (state is NotAuthenticated) {
              Navigator.pushReplacementNamed(context, RouteDefine.login.name);
            }
          },
          child: Center(
            child: Image.asset('assets/icon/app_icon.png', width: 25.w),
          ),
        ),
      ),
    );
  }
}
