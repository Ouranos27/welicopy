import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/user_repository.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/logger.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final String? uId;

  late UserProfileRepository _repository;
  UserToken? _userToken;

  ProfileCubit({this.uId}) : super(ProfileInitial()) {
    injectClass().whenComplete(() async {
      if (uId != null) {
        await loadProfileByUserId(uId!);
        await loadCardsById(uId!);
      } else {
        await loadProfile();
        await loadMyCards();
      }
    });
  }

  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = UserProfileRepository(_networkFactory);
  }

  Future<void> loadProfile() async {
    try {
      var response = await _repository.getUserInfo();
      emit(ProfileLoaded(response));
    } catch (e) {
      logger.e(e.toString());
      await loadProfile();
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> loadProfileByUserId(String uId) async {
    try {
      var response = await _repository.getUserInfoById(uId);
      emit(ProfileLoaded(response));
    } catch (e) {
      logger.e(e.toString());
      await loadProfileByUserId(uId);
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> loadMyCards() async {
    try {
      var data = await _repository.getCardsByUserId("${_userToken?.uid}");
      emit(MyCardLoaded(data));
    } catch (e) {
      debugConsoleLog(e);
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> loadCardsById(String uId) async {
    try {
      var data = await _repository.getCardsByUserId(uId);
      emit(MyCardLoaded(data));
    } catch (e) {
      debugConsoleLog(e);
      await Fluttertoast.showToast(msg: e.toString());
    }
  }
}
