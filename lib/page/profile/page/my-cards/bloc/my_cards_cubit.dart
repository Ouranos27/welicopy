import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/cards_repository.dart';
import 'package:weli/service/repository/user_repository.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/logger.dart';

part 'my_cards_state.dart';

class MyCardsCubit extends Cubit<MyCardsState> {
  final String userId;
  late UserProfileRepository _repository;
  late CardRepository _cardRepository;
  UserToken? _userToken;

  MyCardsCubit(this.userId) : super(MyCardsInitial()) {
    injectClass().whenComplete(() async {
      await loadCardsById();
    });
  }

  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = UserProfileRepository(_networkFactory);
    _cardRepository = CardRepository(_networkFactory);
  }

  Future<void> loadCardsById() async {
    try {
      emit(MyCardLoading());
      var data = await _repository.getCardsByUserId(userId);
      emit(MyCardLoaded(data));
    } catch (e) {
      debugConsoleLog(e);
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<bool> deleteCardById(String cardId) async {
    try {
      emit(MyCardLoading());
      await _cardRepository.deleteCardById(cardId);
    } catch (e) {
      debugConsoleLog(e);
      await Fluttertoast.showToast(msg: e.toString());
      return false;
    }
    return true;
  }
}
