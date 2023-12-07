import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/main/bloc/main_bloc.dart';
import 'package:weli/page/message/page/room_message_page.dart';
import 'package:weli/page/messenger/page/messenger_page.dart';
import 'package:weli/page/salons/page/type.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';

class MainPage extends StatefulWidget {
  final bool shouldNavigateToProfile;

  const MainPage({
    this.shouldNavigateToProfile = false,
    Key? key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  void initState() {
    getIt<NotificationService>().setup();
    super.initState();

    if (widget.shouldNavigateToProfile) {
      Future.delayed(const Duration(milliseconds: 500), () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MainBloc>(),
      child: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is BottomNavBarIndexChanged) _onItemTapped(state.index);
        },
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              RoomMessagePage(arguments: RoomChatArgument.defaultRoom),
              Navigator(
                key: AppRouting.wildCardNavigationKey,
                initialRoute: RouteDefine.salons.name,
                onGenerateRoute: AppRouting.generateWildCardRoute,
              ),
              const MessengerPage(),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: _bottomNavBar(context),
        ),
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) => Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: AppColor.dropShadowColor, spreadRadius: 0, blurRadius: 12),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImage.iconWeli),
                activeIcon: SvgPicture.asset(AppImage.iconWeli, color: AppColor.accentColor),
                label: S.of(context).weli,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImage.iconSalon),
                activeIcon: SvgPicture.asset(AppImage.iconSalon, color: AppColor.accentColor),
                label: S.of(context).salon,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImage.iconMessenger),
                activeIcon: SvgPicture.asset(AppImage.iconMessenger, color: AppColor.accentColor),
                label: S.of(context).messenger,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColor.accentColor,
            onTap: _onItemTapped,
          ),
        ),
      );
}
