import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/src/platform_specifics/android/enums.dart'
    as enums;
import 'package:weli/service/service_app/function_service.dart';
import 'package:weli/util/logger.dart';
import 'package:weli/util/route/app_routing.dart';

class NotificationService {
  String? token;

  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() => _notificationService;

  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }

  Future<NotificationService> init() async {
    //Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('launcher_icon');

    //Initialization Settings for iOS
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onSelectNotification);

    _requestIOSPermission();

    await _configFirebaseNotification();

    return this;
  }

  void setup() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Got a onMessageOpenedApp whilst in the foreground!');
      handleClickNotification(message.data);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('Got a message whilst in the foreground!');
      logger.d(message.notification?.title);
      logger.d(message.notification?.body);
      logger.d(message.data);
      NotificationService().showNotification(message);
    });
    setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleClickNotification(initialMessage.data);
    }
  }

  void fcmSubscribe(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  void fcmUnSubscribe(String topic) {
    FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> _configFirebaseNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      await messaging.getToken().then((value) {
        logger.i("token ==========> $value");
        token = value;
      });
    } catch (e) {
      logger.e(e.toString());
    }
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
          android: _androidNotificationDetails, iOS: _iosNotificationDetails),
      payload: jsonEncode(message.data),
    );
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails('channelId', "channelName",
          channelDescription: "channelDescription",
          playSound: true,
          priority: enums.Priority.max,
          importance: Importance.max);

  final DarwinNotificationDetails _iosNotificationDetails =
      const DarwinNotificationDetails(threadIdentifier: 'thread_id');

  void _onSelectNotification(NotificationResponse notificationResponse) {
    switch (notificationResponse.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        final data = jsonDecode(notificationResponse.payload!);
        handleClickNotification(data);
        break;
      case NotificationResponseType.selectedNotificationAction:
        final data = jsonDecode(notificationResponse.payload!);
        handleClickNotification(data);
        break;
    }
    // if (payload != null) {
    //   final data = jsonDecode(payload);
    //   handleClickNotification(data);
    // }
  }
  // void _onSelectNotification(String? payload) {
  //   if (payload != null) {
  //     final data = jsonDecode(payload);
  //     handleClickNotification(data);
  //   }
  // }

  void handleClickNotification(Map<String, dynamic> messageData) {
    final page = messageData["page"] as String;

    if (page == PageLinkAction.anotherProfile.name) {
      final senderId = messageData["senderId"];
      AppRouting.mainNavigationKey.currentState
          ?.pushNamed(RouteDefine.anotherProfile.name, arguments: senderId);
    }
  }
}
