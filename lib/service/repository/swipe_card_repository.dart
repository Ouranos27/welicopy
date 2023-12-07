import 'package:weli/page/profile/page/swipe-card/bloc/home_cubit.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';

class SwipeCardRepository {
  final NetworkFactory _networkFactory;

  SwipeCardRepository(this._networkFactory);

  Future<List<CardData>> getCardsByUserId(String userId) async {
    try {
      var response = await _networkFactory.getSwipeCards(userId);

      return response.map(CardData.fromJson).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CardData>> getFavoriteCards(String userId) async {
    try {
      var response = await _networkFactory.getFavoriteCards(userId);

      return response.map(CardData.fromJson).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> reactCard(String userId, String cardId, ReactState state) async {
    try {
      await _networkFactory.reactCard(userId, cardId, state);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removeLikeCard(String userId, String cardId) async {
    try {
      await _networkFactory.removeLikeCard(userId, cardId);
    } catch (e) {
      throw e.toString();
    }
  }
}
