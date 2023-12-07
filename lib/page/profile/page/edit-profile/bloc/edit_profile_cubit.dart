import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/user_repository.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/util/logger.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  late UserProfileRepository _repository;
  UserToken? _userToken;

  EditProfileCubit() : super(EditProfileInitial()) {
    injectClass();
  }

  var fbKey = GlobalKey<FormBuilderState>();
  XFile? imageFile = XFile('');
  final ImagePicker _picker = ImagePicker();
  String? pictureUrl;

  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = UserProfileRepository(_networkFactory);
  }

  Future<void> editProfile(Map<String, dynamic> values) async {
    try {
      emit(EditProfileLoading());
      if (imageFile != null && imageFile != null && imageFile!.path != '') {
        pictureUrl = await _repository.uploadProfilePicture(File(imageFile!.path), _userToken!.uid!);
      }
      await _repository.upsertUser(_userToken!.uid!, {...values, 'pictureUrl': pictureUrl ?? values['pictureUrl']});
      emit(EditProfileSuccess((values['investment'] as List).cast<String>()));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          emit(EditProfileFailed(S.current.invalid_email));
          break;
        case 'email-already-in-use':
          emit(EditProfileFailed(S.current.email_already_exists));
          break;
        default:
          emit(EditProfileFailed(S.current.error));
          break;
      }
      logger.e(e.toString());
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
