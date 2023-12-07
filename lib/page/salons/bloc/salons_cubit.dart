import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weli/config/data.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/salons_repository.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/logger.dart';

part 'salons_state.dart';

class SalonsCubit extends Cubit<SalonsState> {
  late SalonsRepository _repository;
  UserToken? userToken;
  StreamSubscription<List<SalonLightData>>? salonsData;

  SalonsCubit() : super(SalonsInitial()) {
    injectClass().whenComplete(() async {
      await getMySalons();
    });
  }

  Future<void> injectClass() async {
    userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: userToken);
    _repository = SalonsRepository(_networkFactory);
  }

  Future<void> getMySalons() async {
    try {
      emit(const SalonsLoading());
      salonsData = _repository.getAllSalonsList().listen((event) async {
        final customizeRooms =
            event.where((element) => element.type == ChatroomMessageType.customizeRoom && element.members.contains(userToken!.uid)).toList();
        var generalRooms = event.where((element) => element.type == ChatroomMessageType.generalRoom && element.members.contains(userToken!.uid)).toList();
        final indexDefaultSalon = generalRooms.indexWhere((element) => element.id == AppData.weliDefaultRoomId);
        // put Weli Salon at first
        if(indexDefaultSalon != -1) {
          generalRooms.swap(0, indexDefaultSalon);
        }
        final profileCustomizeRooms = await Future.wait(customizeRooms.map((e) => _repository.getListProfileByListId(e.members)));
        final profileGeneralRooms = await Future.wait(generalRooms.map((e) => _repository.getListProfileByListId(e.members)));
        final otherDefaultRooms =
            event.where((element) => element.type == ChatroomMessageType.generalRoom && !element.members.contains(userToken!.uid)).toList();
        final profileOtherRooms = await Future.wait(otherDefaultRooms.map((e) => _repository.getListProfileByListId(e.members)));
        emit(SalonsLoaded(
            customizeRooms: customizeRooms,
            generalRooms: generalRooms,
            profileCustomizeRooms: profileCustomizeRooms,
            profileGeneralRooms: profileGeneralRooms,
            otherRooms: otherDefaultRooms,
            profileOtherRooms: profileOtherRooms),
        );
      });
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  List<Profile> userList = [];
  List<String> userIdSelected = [];

  void updateUserIdSelected(String userId) {
    emit(const UserIdAdding());
    if (userIdSelected.contains(userId)) {
      userIdSelected.remove(userId);
    } else {
      userIdSelected.add(userId);
    }
    emit(const UserIdAdded());
  }

  Future<void> searchUserByEmail(String key) async {
    try {
      emit(const UserSearching());
      userList = await _repository.searchUserByEmail(key);
      emit(const UserSearched());
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> searchSalon(String key) async {
    try {
      emit(const SalonsSearching());
      final data = await _repository.searchSalon(key);
      final customizeRooms = data.where((element) => element.type == ChatroomMessageType.customizeRoom && element.members.contains(userToken!.uid)).toList();
      final generalRooms = data.where((element) => element.type == ChatroomMessageType.generalRoom && element.members.contains(userToken!.uid)).toList();
      final indexDefaultSalon = generalRooms.indexWhere((element) => element.id == AppData.weliDefaultRoomId);
      // put Weli Salon at first
      if(indexDefaultSalon != -1) {
        generalRooms.swap(0, indexDefaultSalon);
      }
      final otherDefaultRooms = data.where((element) => element.type == ChatroomMessageType.generalRoom && !element.members.contains(userToken!.uid)).toList();
      final profileCustomizeRooms = await Future.wait(customizeRooms.map((e) => _repository.getListProfileByListId(e.members)));
      final profileGeneralRooms = await Future.wait(generalRooms.map((e) => _repository.getListProfileByListId(e.members)));
      final profileOtherRooms = await Future.wait(otherDefaultRooms.map((e) => _repository.getListProfileByListId(e.members)));
      emit(
        SalonsLoaded(
          customizeRooms: customizeRooms,
          generalRooms: generalRooms,
          profileCustomizeRooms: profileCustomizeRooms,
          profileGeneralRooms: profileGeneralRooms,
          profileOtherRooms: profileOtherRooms,
          otherRooms: otherDefaultRooms
        ),
      );
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<bool> createSalon(Map<String, dynamic> params) async {
    try {
      emit(const SalonCreating());
      await _repository.createNewSalons(params);
      emit(const SalonCreated());
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return true;
  }

  @override
  Future<void> close() {
    if (salonsData != null) salonsData!.cancel();
    return super.close();
  }
}
