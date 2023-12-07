import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/user_repository.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/util/logger.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final _authService = getIt<AuthService>();
  UserProfileRepository _repository = UserProfileRepository(NetworkFactory());
  late UserToken userToken;

  RegisterCubit() : super(RegisterInitial());
  XFile imageFile = XFile('');
  final ImagePicker _picker = ImagePicker();
  var pictureUrl;

  Future<void> register(Map<String, dynamic> data) async {
    if (data['password'] != data['passwordConfirmation']) {
      emit(Error());
      emit(RegisterFailed(S.current.not_identical_password));
    } else {
      try {
        emit(RegisterLoading());
        var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: data["email"], password: data["password"]);
        var user = response.user!;
        userToken = UserToken.fromUserFireBase(user);
        _repository = UserProfileRepository(NetworkFactory(user: userToken));
        if (imageFile.path != '') {
          pictureUrl = await _repository.uploadProfilePicture(File(imageFile.path), user.uid);
        }

        var dataRegister = {...data, 'pictureUrl': pictureUrl};
        dataRegister.remove('password');
        dataRegister.remove('passwordConfirmation');

        await _repository.upsertUser(user.uid, dataRegister);
        await _authService.saveToken(userToken);
        emit(RegisterSuccess((data["investment"] as List).cast<String>()));
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            emit(RegisterFailed(S.current.invalid_email));
            break;
          case 'email-already-in-use':
            emit(RegisterFailed(S.current.email_already_exists));
            break;
          case 'weak-password':
            emit(RegisterFailed(S.current.invalid_password));
            break;
          default:
            emit(RegisterFailed(S.current.error));
            break;
        }
        logger.e(e.toString());
      }
    }
  }

  Future<void> onImageButtonPressed(ImageSource source, {BuildContext? context}) async {
    emit(ImageLoading());
    (await _picker.pickImage(imageQuality: 60, source: source).then((value) {
      if (value != null) {
        imageFile = value;
      }
      return value;
    }));
    emit(ImageLoaded());
  }
}
