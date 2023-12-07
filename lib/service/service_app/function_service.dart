import 'package:dio/dio.dart';
import 'package:weli/config/app_config.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/provider/network_factory.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/logger.dart';

enum PageLinkAction { main, anotherProfile }

class CustomFunctionService {
  UserToken? _userToken;
  List<SalonLightData> generalSalons = [];

  //Singleton pattern
  static final CustomFunctionService _notificationService = CustomFunctionService._internal();

  factory CustomFunctionService.init() => _notificationService;

  CustomFunctionService._internal();

  Future<NetworkFactory> _injectClass() async {
    _userToken = await getIt<AuthService>().getToken();
    return NetworkFactory(user: _userToken);
  }

  Future<void> addThisUserToDefaultSalon(String salonId) async {
    try {
      final networkFactory = await _injectClass();
      if (_userToken != null) {
        await networkFactory.addMembersToSalon(memberIds: ["${_userToken!.uid}"], salonId: salonId);
      }
    } catch (e) {
      debugConsoleLog(e);
    }
  }

  Future<String> getSalonIdByName(String salonName) async {
    try {
      final networkFactory = await _injectClass();
      if (_userToken != null) {
        final data = await networkFactory.getSalonIdByName(salonName);
        final result = data.map(SalonLightData.fromJson).toList();
        return result.first.id;
      }
    } catch (e) {
      debugConsoleLog(e);
    }
    return '';
  }

  Future<void> saveDeviceTokenToFirebase() async {
    try {
      final _networkFactory = await _injectClass();

      if (_userToken != null) {
        final deviceToken = getIt<NotificationService>().token;
        await _networkFactory.updateDeviceTokenToProfile("$deviceToken");
      }
    } catch (e) {
      debugConsoleLog(e);
    }
  }

  Future<void> clearDeviceToken() async {
    try {
      final _networkFactory = await _injectClass();
      final deviceToken = getIt<NotificationService>().token;
      await _networkFactory.clearToken("$deviceToken");
    } catch (e) {
      debugConsoleLog(e);
    }
  }

  Future<void> sendNotificationChatPeerToPeerTo(
    List<String> receivers, {
    required String body,
    PageLinkAction page = PageLinkAction.main,
    String? sender,
  }) async {
    try {
      final _networkFactory = await _injectClass();
      final listReceiver = await Future.wait(receivers.map(_networkFactory.getProfileById));

      final listTokens = listReceiver.map(Profile.fromJson).expand((element) => element.deviceToken).toList();

      final dio = Dio(
        BaseOptions(
          baseUrl: "https://fcm.googleapis.com",
          method: 'POST',
          headers: {"Authorization": AppDev.firebaseKey},
        ),
      );

      final data = {
        "notification": {
          "title": "Notification",
          "body": "$body",
          // "imageUrl": "https://my-cdn.com/extreme-weather.png",
        },
        "data": {
          // "main_picture":
          //     "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "page": page.name,
          "senderId": sender,
        },
        "registration_ids": listTokens,
        "priority": "high"
      };

      if (listTokens.isNotEmpty) await dio.post('/fcm/send', data: data);
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
