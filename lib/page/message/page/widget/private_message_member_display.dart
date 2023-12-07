import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/bloc/message_cubit.dart';
import 'package:weli/service/service_app/function_service.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';

class PrivateMessageMemberDisplay extends StatelessWidget {
  final String uId;

  const PrivateMessageMemberDisplay({
    required this.uId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<MessageCubit, MessageState>(
        buildWhen: (prev, now) => now is AllProfilesLoaded,
        listener: (context, state) {
          if (state is MessageSent) {
            getIt<CustomFunctionService>().sendNotificationChatPeerToPeerTo([uId], body: S.current.privateMessageNotification);
          }
        },
        builder: (context, state) {
          if (state is AllProfilesLoaded) {
            final user = state.profiles.firstWhere((element) => element.id == uId);

            return GestureDetector(
              onTap: () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.anotherProfile.name, arguments: user.id),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileAvatar(
                    size: 60,
                    pictureUrl: user.pictureUrl,
                    firstName: user.firstName,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
                  )
                ],
              ),
            );
          }

          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: SpinKitThreeBounce(color: AppColor.accentColor, size: 20),
          );
        },
      ),
    );
  }
}
