import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/message_repository.dart';
import 'package:weli/service/repository/user_repository.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/logger.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final ChatroomMessageType roomType;
  final String id;

  UserToken? _userToken;
  late final String roomId;
  late final MessageRepository _repository;
  late final UserProfileRepository _profileRepository;
  List<Profile> chatProfile = <Profile>[];
  StreamSubscription<List<MessageLightData>>? messageData;

  MessageCubit({this.roomType = ChatroomMessageType.generalRoom, required this.id}) : super(MessageInitial()) {
    injectClass().whenComplete(
      () async {
        switch (roomType) {
          case ChatroomMessageType.generalRoom:
          case ChatroomMessageType.customizeRoom:
            await _setUpAndLoadProfileRoomChat(id);
            roomId = id;
            await loadChatData(roomId);
            break;
          case ChatroomMessageType.privateRoom:
            roomId = (await _setUpAndLoadProfilePrivateChat(id))!;
            await loadChatData(roomId);
            break;
        }
      },
    );
  }

  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = MessageRepository(_networkFactory);
    _profileRepository = UserProfileRepository(_networkFactory);
  }

  Future<String?> _setUpAndLoadProfilePrivateChat(String id) async {
    try {
      var room = await _repository.getPrivateRoomByUserId(uId: '${_userToken?.uid}', anotherUid: id);

      if (room == null) {
        await _repository.createPrivateRoomForUid(uId: '${_userToken?.uid}', anotherUid: id);
        room = await _repository.getPrivateRoomByUserId(uId: '${_userToken?.uid}', anotherUid: id);
      }
      chatProfile = await _repository.getListProfileByListId(room!.members);
      emit(AllProfilesLoaded(chatProfile));
      return room.id;
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<void> _setUpAndLoadProfileRoomChat(String id) async {
    emit(const AllProfilesLoading());
    final room = await _repository.getRoomById(id);
    if (room != null) {
      chatProfile = await _repository.getListProfileByListId(room.members);
    }
    emit(AllProfilesLoaded(chatProfile));
  }

  Future<void> loadAllProfileChat(String id) async {
    emit(const AllProfilesLoading());
    final room = await _repository.getRoomById(id);
    if (room != null) {
      chatProfile = await _repository.getListProfileByListId(room.members);
    }
    emit(AllProfilesLoaded(chatProfile));
  }

  RefreshController refreshController = RefreshController(initialRefresh: false);
  int _take = 20;

  void onLoading() {
    _take += 20;
    loadChatData(roomId, take: _take);
    Future.delayed(const Duration(milliseconds: 1000), refreshController.loadComplete);
  }

  Future<void> loadChatData(String id, {int? take}) async {
    try {
      await messageData?.cancel();
      messageData = _repository.loadChatDataByRoomId(id, limit: take ?? 20).listen((event) => emit(MessageLoaded(event)));
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<bool> removeMembersFromSalon({required String salonId, required List<String> memberIds}) async {
    try {
      emit(const AllProfilesLoading());
      await _repository.removeMembersFromSalon(salonId: salonId, memberIds: memberIds);
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return true;
  }

  Future<Profile> getProfileById(String id) async {
    final profile = chatProfile.firstWhereOrNull((e) => e.id == id);
    if (profile != null) return profile;

    return await _profileRepository.getUserInfoById(id);
  }

  Future<void> sendMessage(String message) async {
    try {
      await _repository.sendMessage(roomId, message: message, uId: "${_userToken?.uid}");
      emit(MessageSent(message));
    } catch (e) {
      debugConsoleLog(e);
    }
  }

  @override
  Future<void> close() {
    messageData?.cancel();
    return super.close();
  }
}
