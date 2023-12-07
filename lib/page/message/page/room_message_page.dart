import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/data.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/bloc/message_cubit.dart';
import 'package:weli/page/salons/page/type.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/util/route/app_routing.dart';
import 'package:weli/util/utils.dart';

import 'widget/form_message_input.dart';
import 'widget/main_messaging.dart';
import 'widget/room_message_member_display.dart';

class RoomMessagePage extends StatelessWidget {
  final RoomChatArgument arguments;

  const RoomMessagePage({required this.arguments, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = MessageCubit(roomType: arguments.roomType, id: arguments.roomId);

    return BlocProvider(
      create: (_) => bloc,
      child: AppMessageScaffold(
        title: arguments.roomName,
        isBack: arguments.canPopBack,
        action: UserIconButton(onPressed: () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name)),
        titleAction: GestureDetector(
          onTap: () => manageRoom(context, bloc),
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: const Icon(Icons.more_horiz_outlined, color: AppColor.accentColor, size: 15 * 1.5),
          ),
        ),
        body: Column(
          children: [
            const RoomMessageMemberDisplay(),
            MainMessagingWidget(messageType: arguments.roomType),
            const FormMessageInput(),
          ],
        ),
      ),
    );
  }

  void manageRoom(BuildContext context, MessageCubit bloc) {
    final userId = getIt<AuthService>().token!.uid;
    final bool isAdmin = (arguments.roomCreator != null && arguments.roomCreator == userId);
    if (isAdmin) {
      AppRouting.wildCardNavigationKey.currentState?.pushNamed(
        RouteDefine.manageRooms.name,
        arguments: RoomChatArgument(roomId: arguments.roomId, roomType: arguments.roomType, roomName: arguments.roomName),
      ).whenComplete(() => bloc.loadAllProfileChat(arguments.roomId));
    } else {
      if(arguments.roomId != AppData.weliDefaultRoomId){
        showDialog(
          context: context,
          builder: (_context) => ContinueDialog(
            text: S.of(context).quitRoom,
            isRequired: false,
            onContinue: () async {
              if (await bloc.removeMembersFromSalon(salonId: arguments.roomId, memberIds: ['$userId'])) {
                Navigator.pop(context);
              }
            },
            buttonText: S.of(context).next,
            bodyChild: SizedBox(height: 10.h),
          ),
          barrierDismissible: false,
        );
      } else {
        Utils.showSnackBar(context, S.of(context).cannotLeaveDefaultRoomChat);
      }
    }
  }
}
