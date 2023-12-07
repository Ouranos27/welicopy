import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/page/salons/page/create_salon.dart';
import 'package:weli/page/salons/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';

class SalonCardList extends StatelessWidget {
  final List<SalonLightData> listRooms;
  final List<List<Profile>> members;
  final bool isOnMessengerModule;
  final bool creatable;
  final ChatroomMessageType roomType;

  const SalonCardList({
    required this.listRooms,
    this.isOnMessengerModule = false,
    this.creatable = false,
    required this.members,
    required this.roomType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = <Color>[
      const Color(0xFFFED994),
      const Color(0xFF21C8D1),
      const Color(0xFF9EE5EB),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3.w),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(maxWidth: 180.w),
              child: Wrap(
                children: [
                  if (creatable) Padding(padding: EdgeInsets.only(left: 3.w), child: const CreateSalon()),
                  ...listRooms
                      .toList()
                      .asMap()
                      .entries
                      .map(
                        (e) => salonElement(context: context, data: e.value, backgroundColor: colors[e.key % (colors.length)], indexSalon: e.key),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 4.w),
      ],
    );
  }

  Widget salonElement({required BuildContext context, required SalonLightData data, required Color backgroundColor, required int indexSalon}) {
    return GestureDetector(
      onTap: () {
        // context.read<MainBloc>().add(ChangeNavbar(0));
        final userId = getIt<AuthService>().token!.uid;
        if (data.members.contains(userId)) {
          Future.delayed(
            const Duration(milliseconds: 50),
            () => AppRouting.wildCardNavigationKey.currentState?.pushNamed(
              RouteDefine.roomMessage.name,
              arguments: RoomChatArgument(roomId: data.id, roomType: roomType, roomCreator: data.creator, roomName: "${data.name}"),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (_context) => ContinueDialog(
              text: S.of(context).joinRoom,
              isRequired: false,
              onContinue: () async {
                await getIt<CustomFunctionService>().addThisUserToDefaultSalon(data.id).whenComplete(
                      () => Future.delayed(
                        const Duration(milliseconds: 50),
                        () => AppRouting.wildCardNavigationKey.currentState?.pushNamed(
                          RouteDefine.roomMessage.name,
                          arguments: RoomChatArgument(roomId: data.id, roomType: roomType, roomCreator: data.creator, roomName: "${data.name}"),
                        ),
                      ),
                    );
              },
              buttonText: S.of(context).next,
              bodyChild: SizedBox(height: 10.h),
            ),
            barrierDismissible: false,
          );
        }
      },
      child: Container(
        height: 40.w,
        width: 40.w,
        padding: EdgeInsets.all(2.w),
        margin: EdgeInsets.only(left: 3.w, bottom: 3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          boxShadow: [BoxShadow(color: backgroundColor, blurRadius: 6, offset: const Offset(0, 3))],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20.w,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${data.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColor.textColor, fontWeight: AppFontWeight.semiBold, fontSize: 17),
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: 10.w,
              alignment: Alignment.centerRight,
              child: Stack(
                alignment: Alignment.centerRight,
                children: List.generate(
                  data.members.length <= 4 ? data.members.length : 4,
                  (index) => Positioned(
                    left: 6.w * index,
                    child: ProfileAvatar(
                      size: 10.w,
                      firstName: members[indexSalon][index].firstName,
                      isOnline: false,
                      pictureUrl: members[indexSalon][index].pictureUrl,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                data.members.length > 100 ? '+100' : '${data.members.length}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, color: AppColor.textFormColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
