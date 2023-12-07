import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/bloc/message_cubit.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';
import 'package:weli/util/utils.dart';

class MainMessagingWidget extends StatefulWidget {
  final ChatroomMessageType messageType;

  const MainMessagingWidget({
    required this.messageType,
    Key? key,
  }) : super(key: key);

  @override
  State<MainMessagingWidget> createState() => _MainMessagingWidgetState();
}

class _MainMessagingWidgetState extends State<MainMessagingWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoScrollbar(
        child: BlocBuilder<MessageCubit, MessageState>(
          buildWhen: (prev, now) => now is MessageLoaded,
          builder: (context, state) {
            if (state is MessageLoaded) {
              // Group message based on date [DESC].
              final messagesGrouped =
                  groupBy<MessageLightData, String>(state.messages, (data) => Utils.parseDateToString(data.sendDate!, "MMM.dd")).entries;

              return SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                header: const WaterDropMaterialHeader(backgroundColor: AppColor.accentColor),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                  loadingText: S.of(context).loadingText,
                  noDataText: S.of(context).noDataText,
                  canLoadingText: S.of(context).idleText,
                  idleText: S.of(context).idleText,
                  completeDuration: const Duration(milliseconds: 500),
                  canLoadingIcon: const Icon(Icons.autorenew, color: Colors.black87),
                  textStyle: Theme.of(context).textTheme.bodyText1!,
                  loadingIcon: const SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: SpinKitThreeBounce(color: AppColor.accentColor, size: 12),
                  ),
                ),
                controller: context.read<MessageCubit>().refreshController,
                onLoading: context.read<MessageCubit>().onLoading,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  reverse: true,
                  itemCount: messagesGrouped.length,
                  itemBuilder: (context, index) {
                    final e = messagesGrouped.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          ...e.value.map(MessageCard.new),
                          Text(
                            e.key,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final MessageLightData messageData;

  const MessageCard(
    this.messageData, {
    Key? key,
  }) : super(key: key);

  bool get isMyMessage => messageData.senderData == getIt<AuthService>().token?.uid;

  @override
  Widget build(BuildContext context) {
    final children = [
      FutureBuilder<Profile>(
        future: context.read<MessageCubit>().getProfileById("${messageData.senderData}"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text(
                  "${snapshot.data?.firstName}",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 10),
                ),
                GestureDetector(
                  child: ProfileAvatar(
                    margin: const EdgeInsets.fromLTRB(4, 4, 4, 8),
                    size: 36,
                    pictureUrl: snapshot.data?.pictureUrl,
                    firstName: snapshot.data?.firstName,
                  ),
                  onTap: () {
                    final uId = snapshot.data!.id;
                    uId != getIt<AuthService>().token?.uid
                        ? AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.anotherProfile.name, arguments: uId)
                        : AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name, arguments: uId);
                  },
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ).copyWith(
            bottomLeft: isMyMessage ? const Radius.circular(10) : null,
            bottomRight: isMyMessage ? null : const Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.dropShadowColor,
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        width: 70.w,
        child: Text(
          "${messageData.text}",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColor.textColor,
                fontWeight: AppFontWeight.normal,
              ),
        ),
      )
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...isMyMessage ? children.reversed : children,
        ],
      ),
    );
  }
}
