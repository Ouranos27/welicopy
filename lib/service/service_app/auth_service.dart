import 'package:weli/database/secure_storage_helper.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/util/logger.dart';

class AuthService {
  UserToken? token;

  Future<AuthService> init() async {
    final currentToken = await SecureStorageHelper.getInstance().getToken();
    if (currentToken != null) {
      token = currentToken;
    }
    return this;
  }

  /// Handle save/remove Token
  Future<void> saveToken(UserToken token) async {
    try {
      return await SecureStorageHelper.getInstance().saveToken(token);
    } catch (e) {
      logger.e(e.toString());
      throw Exception();
    }
  }

  Future<UserToken?> getToken() async {
    try {
      final currentToken = await SecureStorageHelper.getInstance().getToken();
      token = currentToken!;
      return token;
    } catch (e) {
      return null;
    }
  }

  void removeToken() {
    return SecureStorageHelper.getInstance().removeToken();
  }

  Future<String?> getStringToken() async {
    final token = await getToken();
    return token?.uid;
  }

  Future<String?> getStringRefreshToken() async {
    final token = await getToken();
    return token?.refreshToken;
  }

  /// SignOut
  void signOut() async {
    removeToken();
  }
}
