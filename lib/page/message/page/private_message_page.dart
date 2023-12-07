import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/message/bloc/message_cubit.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/util/route/app_routing.dart';

import 'widget/form_message_input.dart';
import 'widget/main_messaging.dart';
import 'widget/private_message_member_display.dart';

class PrivateMessagePage extends StatelessWidget {
  final String uId;

  const PrivateMessagePage({required this.uId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageCubit(roomType: ChatroomMessageType.privateRoom, id: uId),
      child: AppMessageScaffold(
        title: S.of(context).privateChatroom,
        action: UserIconButton(
          onPressed: () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name),
        ),
        body: Column(
          children: [
            PrivateMessageMemberDisplay(uId: uId),
            const MainMessagingWidget(messageType: ChatroomMessageType.privateRoom),
            const FormMessageInput(),
          ],
        ),
      ),
    );
  }
}
