import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/token_entity.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/cards_repository.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/util/logger.dart';

part 'create_card_state.dart';

class CreateCardCubit extends Cubit<CreateCardState> {
  UserToken? _userToken;
  late CardRepository _repository;

  CreateCardCubit() : super(CreateCardInitial()) {
    injectClass();
  }

  var fbKey = GlobalKey<FormBuilderState>();
  XFile imageFile = XFile('');
  final ImagePicker _picker = ImagePicker();
  String? pictureUrl;

  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = CardRepository(_networkFactory);
  }

  Future<void> createCard(Map<String, dynamic> values) async {
    try {
      emit(CreateCardLoading());
      if (imageFile.path != '') {
        pictureUrl = await _repository.uploadCardPicture(File(imageFile.path), _userToken!.uid!);
      }
      var data = {
        ...values,
        'landArea': values['landArea'] != null ? values['landArea'].toString() : null,
        'livingSpace': values['livingSpace'] != null ? values['livingSpace'].toString() : null,
        'numberOfBatches': values['numberOfBatches'] != null ? values['numberOfBatches'].toString() : null,
        'price': values['price'] != null ? values['price'].toString() : null,
        'pricePerSquareMeters': values['pricePerSquareMeters'] != null ? values['pricePerSquareMeters'].toString() : null,
        "userId": _userToken?.uid,
        'pictureUrl': pictureUrl
      };
      debugConsoleLog(data);
      await _repository.createNewCard(data);
      emit(CreateCardSuccess());
    } catch (e) {
      print(e);
    }
  }

  Future<void> editCard(Map<String, dynamic> values, String cardId) async {
    emit(CreateCardLoading());
    if (imageFile.path != '') {
      pictureUrl = await _repository.uploadCardPicture(File(imageFile.path), _userToken!.uid!);
    }
    var data = {
      ...values,
      'landArea': values['landArea'] != null ? values['landArea'].toString() : null,
      'livingSpace': values['livingSpace'] != null ? values['livingSpace'].toString() : null,
      'numberOfBatches': values['numberOfBatches'] != null ? values['numberOfBatches'].toString() : null,
      'price': values['price'] != null ? values['price'].toString() : null,
      'pricePerSquareMeters': values['pricePerSquareMeters'] != null ? values['pricePerSquareMeters'].toString() : null,
      'pictureUrl': pictureUrl ?? values['pictureUrl']
    };
    debugConsoleLog(data);
    await _repository.editCard(data, cardId);
    emit(CreateCardSuccess());
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
