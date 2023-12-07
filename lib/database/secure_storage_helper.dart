import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/util/logger.dart';

import 'share_preferences_helper.dart';

class SecureStorageHelper {
  static const _apiTokenKey = '_apiTokenKey';

  final FlutterSecureStorage _storage;

  SecureStorageHelper._internal(this._storage);

  static final SecureStorageHelper _singleton = SecureStorageHelper._internal(const FlutterSecureStorage());

  factory SecureStorageHelper() => _singleton;

  factory SecureStorageHelper.getInstance() => _singleton;

  //Save token
  Future<void> saveToken(UserToken token) async {
    try {
      await _storage.write(key: _apiTokenKey, value: jsonEncode(token.toJson()));
      SharedPreferencesHelper.setApiTokenKey(_apiTokenKey);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  //Remove token
  void removeToken() async {
    await _storage.delete(key: _apiTokenKey);
    SharedPreferencesHelper.removeApiTokenKey();
  }

  //Get token
  Future<UserToken?> getToken() async {
    try {
      final key = await SharedPreferencesHelper.getApiTokenKey();
      final tokenEncoded = await _storage.read(key: key);
      if (tokenEncoded == null) {
        return null;
      } else {
        return UserToken.fromJson(jsonDecode(tokenEncoded) as Map<String, dynamic>);
      }
    } catch (e) {
      return null;
    }
  }
}
