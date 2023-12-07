import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/main/bloc/main_bloc.dart';
import 'package:weli/page/messenger/bloc/messenger_cubit.dart';
import 'package:weli/page/salons/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/util/route/app_routing.dart';

class CustomizeRoomMessageResultList extends StatelessWidget {
  const CustomizeRoomMessageResultList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).myRooms2,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColor.accentColor,
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 16,
                ),
          ),
          BlocBuilder<MessengerCubit, MessengerState>(
            buildWhen: (prev, now) => now is MessengerDataLoaded || now is MessengerLoading,
            builder: (context, state) {
              if (state is MessengerDataLoaded) {
                return SizedBox(
                  height: 43.w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.customizeRooms.length,
                    itemBuilder: (context, index) {
                      return salonElement(
                        context: context,
                        data: state.customizeRooms[index],
                        backgroundColor: AppColor.roomCardColors[index % AppColor.roomCardColors.length],
                        profiles: state.profileCustomizeRooms[index],
                      );
                    },
                  ),
                );
              }

              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: SpinKitThreeBounce(color: AppColor.accentColor, size: 20),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget salonElement({
    required BuildContext context,
    required SalonLightData data,
    required List<Profile> profiles,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: () {
        getIt<MainBloc>().add(ChangeNavbar(1));
        Future.delayed(
          const Duration(milliseconds: 50),
          () => AppRouting.wildCardNavigationKey.currentState?.pushNamed(
            RouteDefine.roomMessage.name,
            arguments: RoomChatArgument(
              roomId: data.id,
              roomType: data.type,
              roomCreator: data.creator,
              roomName: "${data.name}",
            ),
          ),
        );
      },
      child: Container(
        height: 40.w,
        width: 40.w,
        padding: EdgeInsets.all(2.w),
        margin: EdgeInsets.all(1.5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(color: backgroundColor, blurRadius: 6, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${data.name}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColor.textColor, fontWeight: AppFontWeight.semiBold, fontSize: 18),
              ),
            ),
            const Spacer(),
            Container(
              height: 10.w,
              alignment: Alignment.centerRight,
              child: Stack(
                alignment: Alignment.centerRight,
                children: List.generate(
                  min(data.members.length, 4),
                  (index) => Positioned(
                    left: 6.w * index,
                    child: ProfileAvatar(
                      size: 10.w,
                      firstName: profiles[index].firstName,
                      isOnline: false,
                      pictureUrl: profiles[index].pictureUrl,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                data.members.length > 4 ? '+${data.members.length - 4}' : '',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12, color: AppColor.textFormColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
