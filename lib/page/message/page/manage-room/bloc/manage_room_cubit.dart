import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/profile.dart';
import 'package:weli/service/model/entities/token_entity.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/message_repository.dart';
import 'package:weli/service/repository/salons_repository.dart';
import 'package:weli/service/repository/user_repository.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/util/logger.dart';

part 'manage_room_state.dart';

class ManageRoomCubit extends Cubit<ManageRoomState> {
  UserToken? _userToken;
  late final String id;
  late final SalonsRepository _salonRepository;
  late final MessageRepository _repository;
  late final UserProfileRepository _profileRepository;
  List<Profile> memberList = <Profile>[];

  ManageRoomCubit({required this.id}) : super(ManageRoomInitial()) {
    injectClass().whenComplete(loadProfileRoomChat);
  }

  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = MessageRepository(_networkFactory);
    _salonRepository = SalonsRepository(_networkFactory);
    _profileRepository = UserProfileRepository(_networkFactory);
  }

  Future<void> loadProfileRoomChat() async {
    emit(const AllProfilesLoading());
    final room = await _repository.getRoomById(id);
    if (room != null) {
      memberList = await _repository.getListProfileByListId(room.members);
    }
    emit(AllProfilesLoaded(memberList));
  }

  Future<bool> removeMembersFromSalon({required List<String> memberIds}) async {
    try {
      emit(const AllProfilesLoading());
      await _repository.removeMembersFromSalon(salonId: id, memberIds: memberIds);
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return true;
  }

  Future<Profile> getProfileById(String userId) async {
    final profile = memberList.firstWhereOrNull((e) => e.id == userId);
    if (profile != null) return profile;

    return await _profileRepository.getUserInfoById(userId);
  }
  
  Future<bool> deleteSalon() async {
    try {
      emit(const AllProfilesLoading());
      await _salonRepository.deleteSalon(id);
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return true;
  }

  Future<bool> addUsersToSalon(List<String> userIds) async {
    try {
      emit(const AllProfilesLoading());
      await _salonRepository.addUsersToSalon(id, userIds);
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return true;
  }

  List<Profile> userList = [];

  Future<void> searchUserToAddToSalon(String key) async {
    try {
      emit(const UserSearching());
      userList = await _salonRepository.searchUserByEmail(key);
      emit(const UserSearched());
    } catch (e) {
      logger.e(e.toString());
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

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
}
