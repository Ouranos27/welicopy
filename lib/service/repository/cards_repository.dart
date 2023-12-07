import 'dart:io';

import 'package:weli/service/provider/network_factory.dart';

class CardRepository {
  final NetworkFactory _networkFactory;

  CardRepository(this._networkFactory);

  Future<String?> uploadCardPicture(File profilePicture, String userId) async {
    try {
      return await _networkFactory.uploadPicture(folder: 'cardPics', pic: profilePicture, userId: userId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> createNewCard(Map<String, dynamic> data) async {
    try {
      await _networkFactory.createNewCard(data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> editCard(Map<String, dynamic> data, String cardId) async {
    try {
      await _networkFactory.editCard(data, cardId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteCardById(String cardId) async {
    try {
      await _networkFactory.deleteCardById(cardId);
    } catch (e) {
      throw e.toString();
    }
  }
}
