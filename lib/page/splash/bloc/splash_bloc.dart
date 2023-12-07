import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/util/logger.dart';

import '../../../main.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final authService = getIt<AuthService>();

  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is InitStart) {
        await Future.delayed(const Duration(seconds: 2));
        try {
          var user = await authService.getToken();
          if (user != null) {
            logger.d(user.toJson());
            emit(Authenticated());
          } else {
            emit(NotAuthenticated());
          }
        } catch (e) {
          logger.e(e.toString());
          emit(NotAuthenticated());
        }
      }
    });
  }
}
