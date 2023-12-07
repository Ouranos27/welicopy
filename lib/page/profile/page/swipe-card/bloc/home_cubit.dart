import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tcard/tcard.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/repository/swipe_card_repository.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/logger.dart';

part 'home_state.dart';

enum ReactState { like, dislike }

class HomeCubit extends Cubit<HomeState> {
  final String uId;
  final bool isFavoriteCard;

  late SwipeCardRepository _repository;
  UserToken? _userToken;

  var tCardController = TCardController();

  HomeCubit(this.uId, {this.isFavoriteCard = false}) : super(HomeInitial()) {
    injectClass().whenComplete(() async {
      isFavoriteCard ? await loadFavoriteCards() : await loadUserSwipeCards();
    });
  }

  //
  Future<void> injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    var _networkFactory = NetworkFactory(user: _userToken);
    _repository = SwipeCardRepository(_networkFactory);
  }

  Future<void> loadUserSwipeCards() async {
    try {
      emit(SwipeCardLoading());
      var data = await _repository.getCardsByUserId(uId);

      emit(SwipeCardLoaded(data));
    } catch (e) {
      debugConsoleLog(e);
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> loadFavoriteCards() async {
    try {
      emit(FavoriteCardLoading());
      var data = await _repository.getFavoriteCards(uId);

      emit(FavoriteCardLoaded(data));
    } catch (e) {
      debugConsoleLog(e);
      await Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> databaseReact(String cardId, {required ReactState state}) async {
    try {
      await _repository.reactCard("${_userToken?.uid}", cardId, state);
    } catch (e) {
      debugConsoleLog(e);
    }
  }

  Future<void> removeLikeCard(String cardId) async {
    try {
      emit(LikeCardRemoving());
      await _repository.removeLikeCard("${_userToken?.uid}", cardId);
      emit(LikeCardRemoved());
    } catch (e) {
      debugConsoleLog(e);
      emit(CardError(e));
    }
  }

  void handleTapTabBar(int value) {}
}
