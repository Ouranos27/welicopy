import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/util/logger.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _authService = getIt<AuthService>();

  LoginCubit() : super(LoginInitial());

  var fbKey = GlobalKey<FormBuilderState>();

  Future<void> login() async {
    var data = fbKey.currentState!.value;
    try {
      emit(LoginLoading());
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: data["user_name"], password: data["password"]);
      var user = response.user!;
      await _authService.saveToken(UserToken.fromUserFireBase(user));
      print('token: ${_authService.token?.toJson()}');
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          emit(LoginFailed(S.current.invalid_email));
          break;
        case 'user-disabled':
          emit(LoginFailed(S.current.disabled_account));
          break;
        case 'wrong-password':
          emit(LoginFailed(S.current.wrong_password));
          break;
        default:
          emit(LoginFailed(S.current.no_account));
          break;
      }
      logger.e(e.toString());
    }
  }
}
