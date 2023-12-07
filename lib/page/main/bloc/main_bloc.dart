import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/service_app/service.dart';

import '../../../main.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final _authService = getIt<AuthService>();
  UserToken? _userToken;

  late NetworkFactory _networkFactory;

  MainBloc() : super(MainInitial()) {
    on<MainEvent>((event, emit) async {
      if (event is InitMain) {
        _userToken = await _authService.getToken();
        _networkFactory = NetworkFactory(user: _userToken);
      }

      if (event is ChangeNavbar) {
        emit(BottomNavBarIndexChanged(event.index));
      }
    });
  }
}
