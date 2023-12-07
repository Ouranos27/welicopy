import 'dart:io';

import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';

class UserProfileRepository {
  final NetworkFactory _networkFactory;

  UserProfileRepository(this._networkFactory);

  /// converse to Object
  Future<Profile> getUserInfo() async {
    try {
      var response = await _networkFactory.getProfile();
      if (response.isNotEmpty) {
        var profile = Profile.fromJson(response);
        return profile;
      } else {
        throw ("no data");
      }
      // print(profile.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Profile> getUserInfoById(String uId) async {
    try {
      var response = await _networkFactory.getProfileById(uId);
      if (response.isNotEmpty) {
        var profile = Profile.fromJson(response);
        return profile;
      } else {
        throw ("no data");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /// converse to Object
  Future<List<CardData>> getCardsByUserId(String userId) async {
    try {
      var response = await _networkFactory.getCardsById(userId);

      return response.map(CardData.fromJson).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String?> uploadProfilePicture(File profilePicture, String userId) async {
    try {
      return _networkFactory.uploadPicture(folder: 'profilePics', pic: profilePicture, userId: userId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> upsertUser(String userId, Map<String, dynamic> data) async {
    try {
      await _networkFactory.upsertUser(userId, data);
    } catch (e) {
      throw e.toString();
    }
  }
}