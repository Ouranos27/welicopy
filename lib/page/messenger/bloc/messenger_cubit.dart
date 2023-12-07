import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/salons_repository.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/logger.dart';

part 'messenger_state.dart';

class MessengerCubit extends Cubit<MessengerState> {
  late SalonsRepository _repository;
  UserToken? _userToken;
  StreamSubscription<List<SalonLightData>>? salonsData;

  MessengerCubit() : super(MessengerInitial()) {
    injectClass().whenComplete(() async {
      await loadMyPrivateSalons();
    });
  }

  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = SalonsRepository(_networkFactory);
  }

  Future<void> loadMyPrivateSalons() async {
    try {
      emit(const MessengerLoading());
      salonsData = _repository.getUserSalonList().listen((event) async {
        final privateRooms = event.where((element) => element.type == ChatroomMessageType.privateRoom && element.members.length == 2).toList();
        final customizeRooms = event.where((element) => element.type == ChatroomMessageType.customizeRoom).toList();
        final profilePrivateRooms = await Future.wait(
          privateRooms.map((e) => e.members.where((element) => element != _userToken?.uid).toList()).map(_repository.getListProfileByListId),
        );
        final profileCustomizeRooms = await Future.wait(
          customizeRooms.map((e) => e.members).map(_repository.getListProfileByListId),
        );

        emit(
          MessengerDataLoaded(
            privateRooms: privateRooms,
            profilePrivateRooms: profilePrivateRooms.expand((element) => element).toList(),
            customizeRooms: customizeRooms,
            profileCustomizeRooms: profileCustomizeRooms,
          ),
        );
      });
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> searchSalon(String key) async {
    try {
      emit(const MessengerLoading());

      // Search for private room
      final privateRooms = await _repository.getPrivateSalons();
      final profilePrivateRooms = (await Future.wait(
        privateRooms.map((e) => e.members.where((element) => element != _userToken?.uid).toList()).map(_repository.getListProfileByListId),
      ))
          .expand((element) => element)
          .toList();
      var privateRoomFiltered = <SalonLightData>[];
      var profilePrivateRoomsFiltered = <Profile>[];

      privateRooms.asMap().forEach((index, value) {
        final name = "${profilePrivateRooms[index].firstName} ${profilePrivateRooms[index].lastName}";

        if (name.toLowerCase().replaceAll("[^\\p{ASCII}]", "").contains(key.replaceAll("[^\\p{ASCII}]", "").toLowerCase())) {
          privateRoomFiltered = [...privateRoomFiltered, value];
          profilePrivateRoomsFiltered = [...profilePrivateRoomsFiltered, profilePrivateRooms[index]];
        }
      });

      // Search for customize room
      final data = await _repository.searchSalon(key);
      final customizeRooms = data.where((element) => element.type == ChatroomMessageType.customizeRoom).toList();
      final profileCustomizeRooms = await Future.wait(customizeRooms.map((e) => e.members).map(_repository.getListProfileByListId));

      emit(
        MessengerDataLoaded(
          privateRooms: privateRoomFiltered,
          profilePrivateRooms: profilePrivateRoomsFiltered,
          customizeRooms: customizeRooms,
          profileCustomizeRooms: profileCustomizeRooms,
        ),
      );
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Future<void> close() {
    salonsData?.cancel();
    return super.close();
  }
}
