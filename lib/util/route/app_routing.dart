import 'package:flutter/cupertino.dart';
import 'package:weli/page/forgot-password/page/forgot_password_page.dart';
import 'package:weli/page/login/page/login_page.dart';
import 'package:weli/page/main/page/main_page.dart';
import 'package:weli/page/message/page/manage-room/page/manage_room_page.dart';
import 'package:weli/page/message/page/private_message_page.dart';
import 'package:weli/page/message/page/room_message_page.dart';
import 'package:weli/page/profile/page/another_profile.dart';
import 'package:weli/page/profile/page/create-card/page/create_card_page.dart';
import 'package:weli/page/profile/page/edit-profile/page/edit_profile_page.dart';
import 'package:weli/page/profile/page/my-cards/page/my_cards_page.dart';
import 'package:weli/page/profile/page/profile_page.dart';
import 'package:weli/page/profile/page/swipe-card/page/favorite_card_page.dart';
import 'package:weli/page/profile/page/swipe-card/page/swipe_card_page.dart';
import 'package:weli/page/register/page/register_page.dart';
import 'package:weli/page/salons/page/salons_page.dart';
import 'package:weli/page/salons/page/type.dart';
import 'package:weli/page/splash/page/splash_page.dart';
import 'package:weli/service/model/entities/card.dart';
import 'package:weli/service/model/entities/profile.dart';

enum RouteDefine {
  splash,
  login,
  main,
  register,
  forgotPassword,
  editProfile,
  home,
  mainProfile,
  anotherProfile,
  myCards,
  createCard,
  editCard,
  roomMessage,
  privateMessage,
  salons,
  manageRooms,
  swipeCard,
  favouriteCard,
}

class AppRouting {
  static final mainNavigationKey = GlobalKey<NavigatorState>();
  static final wildCardNavigationKey = GlobalKey<NavigatorState>();

  static CupertinoPageRoute generateMainRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.splash.name: (_) => const SplashPage(),
      RouteDefine.login.name: (_) => const LoginPage(),
      RouteDefine.register.name: (_) => const RegisterPage(),
      RouteDefine.forgotPassword.name: (_) => const ForgotPasswordPage(),
      RouteDefine.editProfile.name: (_) => EditProfilePage(profile: settings.arguments as Profile),
      RouteDefine.main.name: (_) => MainPage(shouldNavigateToProfile: settings.arguments != null && settings.arguments as bool),
      RouteDefine.mainProfile.name: (_) => const ProfilePage(),
      RouteDefine.home.name: (_) => RoomMessagePage(arguments: RoomChatArgument.defaultRoom),
      RouteDefine.salons.name: (_) => const SalonsPage(),
      RouteDefine.myCards.name: (_) => MyCardsPage(userId: "${settings.arguments}"),
      RouteDefine.createCard.name: (_) => const CreateCardPage(),
      RouteDefine.editCard.name: (_) => CreateCardPage(cardData: settings.arguments as CardData),
      RouteDefine.roomMessage.name: (_) => RoomMessagePage(arguments: settings.arguments as RoomChatArgument),
      RouteDefine.privateMessage.name: (_) => PrivateMessagePage(uId: settings.arguments as String),
      RouteDefine.anotherProfile.name: (_) => AnotherProfilePage(userId: "${settings.arguments}"),
      RouteDefine.manageRooms.name: (_) => ManageRoomsPage(arguments: settings.arguments as RoomChatArgument),
      RouteDefine.swipeCard.name: (_) => SwipeCardPage(uId: settings.arguments as String),
      RouteDefine.favouriteCard.name: (_) => FavoriteCardPage(uId: settings.arguments as String),
    };

    final routeBuilder = routes[settings.name];

    return CupertinoPageRoute(
      builder: routeBuilder!,
      settings: RouteSettings(name: settings.name),
    );
  }

  static CupertinoPageRoute generateWildCardRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.salons.name: (_) => const SalonsPage(),
      RouteDefine.roomMessage.name: (_) => RoomMessagePage(arguments: settings.arguments as RoomChatArgument),
      RouteDefine.manageRooms.name: (_) => ManageRoomsPage(arguments: settings.arguments as RoomChatArgument),
      RouteDefine.privateMessage.name: (_) => PrivateMessagePage(uId: settings.arguments as String),
      RouteDefine.anotherProfile.name: (_) => AnotherProfilePage(userId: "${settings.arguments}"),
    };

    final routeBuilder = routes[settings.name];

    return CupertinoPageRoute(
      builder: routeBuilder!,
      settings: RouteSettings(name: settings.name),
    );
  }
}
