import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:weli/config/data.dart';
import 'package:weli/util/logger.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  var fbKey = GlobalKey<FormBuilderState>();

  Future<void> forgotPassword() async {
    var data = fbKey.currentState!.value;
    try {
      emit(ForgotPasswordLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: data["user_name"]);
      emit(ForgotPasswordSuccess(AppData.strings["reset_password_success"]!));
      fbKey.currentState!.reset();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ForgotPasswordFailed(AppData.strings["user_not_found"]!));
      }
      logger.e(e.toString());
    }
  }
}
