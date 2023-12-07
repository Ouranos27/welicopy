import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/page/manage-room/bloc/manage_room_cubit.dart';
import 'package:weli/page/salons/page/type.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/service/service_app/auth_service.dart';
import 'package:weli/service/service_app/function_service.dart';
import 'package:weli/util/route/app_routing.dart';

class ManageRoomsPage extends StatefulWidget {
  final RoomChatArgument arguments;

  const ManageRoomsPage({required this.arguments}) : super();

  @override
  State<ManageRoomsPage> createState() => _ManageRoomsPageState();
}

class _ManageRoomsPageState extends State<ManageRoomsPage> {
  var membersSelected = <String>[];
  final userId = getIt<AuthService>().token!.uid;
  late final ManageRoomCubit bloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = ManageRoomCubit(id: widget.arguments.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.arguments.roomName,
      action: UserIconButton(onPressed: () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          children: [
            addMembersBtn(),
            membersWidget(context),
          ],
        ),
      ),
      bottomWidget: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            deleteRoomBtn(),
            removeMembers(),
          ],
        ),
      ),
    );
  }

  Widget deleteRoomBtn() {
    return CommonButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (_context) => ContinueDialog(
            text: '${S.of(context).deleteRoom} ?',
            isRequired: false,
            onContinue: () async {
              if (await bloc.deleteSalon()) {
                await getIt<CustomFunctionService>().sendNotificationChatPeerToPeerTo(
                  bloc.memberList.map((e) => "${e.id}").toList(),
                  body: S.current.salonRemovedNotification(widget.arguments.roomName),
                );
                AppRouting.wildCardNavigationKey.currentState?.popUntil(ModalRoute.withName(RouteDefine.salons.name));
              }
            },
            buttonText: S.of(context).next,
            bodyChild: SizedBox(height: 10.h),
          ),
          barrierDismissible: false,
        );
      },
      backgroundColor: Colors.red,
      height: 4.h,
      radius: 13,
      child: Text(
        S.of(context).deleteRoom,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color(0xFF072B53),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget removeMembers() {
    return CommonButton(
      onPressed: () async {
        if (membersSelected.isNotEmpty) {
          await showDialog(
            context: context,
            builder: (context) {
              return ContinueDialog(
                text: '${S.of(context).removeFromRoom} ?',
                isRequired: false,
                onContinue: () async {
                  if (await bloc.removeMembersFromSalon(memberIds: membersSelected)) {
                    await bloc.loadProfileRoomChat();
                    await getIt<CustomFunctionService>().sendNotificationChatPeerToPeerTo(
                      membersSelected,
                      body: S.current.removedNotification(widget.arguments.roomName),
                    );
                    membersSelected.clear();
                  }
                },
                buttonText: S.of(context).next,
                bodyChild: SizedBox(height: 10.h),
              );
            },
            barrierDismissible: false,
          );
        }
      },
      backgroundColor: AppColor.accentColor,
      height: 4.h,
      radius: 13,
      child: Text(
        S.of(context).removeFromRoom,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: const Color(0xFF072B53),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget membersWidget(BuildContext context) {
    return BlocBuilder<ManageRoomCubit, ManageRoomState>(
      bloc: bloc,
      buildWhen: (pre, now) => now is AllProfilesLoaded || now is AllProfilesLoading,
      builder: (context, state) {
        if (state is AllProfilesLoaded) {
          return Column(
            children: [
              ...state.profiles
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: ListTile(
                        onTap: () {
                          membersSelected.contains(e.id) ? membersSelected.remove('${e.id}') : membersSelected.add('${e.id}');
                          setState(() {});
                        },
                        minLeadingWidth: 0,
                        leading: membersSelected.contains(e.id)
                            ? Icon(Icons.check_box_outlined, size: 7.w, color: AppColor.textColor)
                            : Icon(Icons.check_box_outline_blank, size: 7.w, color: AppColor.textColor),
                        trailing: IconButton(
                          onPressed: () {
                            final uId = e.id;
                            if (uId != getIt<AuthService>().token?.uid) {
                              AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.anotherProfile.name, arguments: uId);
                            } else {
                              AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name, arguments: uId);
                            }
                          },
                          icon: Icon(Icons.keyboard_arrow_right, size: 7.w),
                        ),
                        title: Row(
                          children: [
                            SvgPicture.string(
                              """<svg width="22.816" height="22.816" viewBox="0 0 22.816 22.816">
                                <defs>
                                </defs>
                                <path class="a"
                                d="M11.408,12.834A6.417,6.417,0,1,0,4.991,6.417,6.419,6.419,0,0,0,11.408,12.834Zm5.7,1.426H14.657a7.757,7.757,0,0,1-6.5,0H5.7a5.7,5.7,0,0,0-5.7,5.7v.713a2.14,2.14,0,0,0,2.139,2.139H20.677a2.14,2.14,0,0,0,2.139-2.139v-.713A5.7,5.7,0,0,0,17.112,14.26Z" />
                                </svg>""",
                              color: AppColor.textColor.withOpacity(0.8),
                              width: 4.5.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              "${e.firstName} ${e.lastName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: AppColor.textColor, fontWeight: FontWeight.w500, fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          );
        }
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: SpinKitThreeBounce(color: AppColor.accentColor, size: 20),
        );
      },
    );
  }

  Widget addMembersBtn() {
    return Align(
      alignment: Alignment.topRight,
      child: CircleButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                bloc.userList.clear();
                bloc.userIdSelected.clear();
                return ContinueDialog(
                  text: S.of(context).inviteParticipants,
                  onContinue: () async {
                    if (await bloc.addUsersToSalon(bloc.userIdSelected)) {
                      await bloc.loadProfileRoomChat();
                      await getIt<CustomFunctionService>()
                          .sendNotificationChatPeerToPeerTo(bloc.userIdSelected, body: S.of(context).invitedNotification);
                    }
                  },
                  buttonText: S.of(context).next,
                  bodyChild: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        SearchBarWeli(
                          hintText: 'example@gmail.com',
                          name: "search",
                          validator: FormBuilderValidators.required(errorText: S.of(context).empty_field_error),
                          onChanged: (value) {
                            if (value != null && value != '') {
                              bloc.searchUserToAddToSalon(value);
                            }
                          },
                        ),
                        BlocBuilder(
                          buildWhen: (pre, now) => now is UserSearched || now is UserSearching,
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is UserSearching) {
                              return const Padding(padding: EdgeInsets.all(15), child: CircularProgressIndicator());
                            }
                            return Container(
                              constraints: BoxConstraints(maxHeight: 55.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [SizedBox(height: 1.h), ...bloc.userList.map(contactElement).toList()],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              barrierDismissible: false);
        },
        icon: const Icon(Icons.add, color: AppColor.accentColor, size: 35),
      ),
    );
  }

  Widget contactElement(Profile profile) {
    final bool isMember = bloc.memberList.map((e) => e.id).toList().contains(profile.id);
    return BlocBuilder<ManageRoomCubit, ManageRoomState>(
      bloc: bloc,
      buildWhen: (pre, now) => now is UserIdAdding || now is UserIdAdded,
      builder: (context, state) => GestureDetector(
        onTap: () {
          if (!isMember) {
            bloc.updateUserIdSelected(profile.id!);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Row(
            children: [
              ProfileAvatar(size: 12.w, pictureUrl: profile.pictureUrl, isOnline: false, firstName: profile.firstName),
              SizedBox(width: 2.w),
              Container(
                width: 52.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isMember ? const Color.fromRGBO(242, 242, 242, 1) : const Color.fromRGBO(0, 0, 0, 0.16)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                      child: Text(
                        '${profile.firstName} ${profile.lastName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColor.textColor, fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    const Spacer(),
                    (isMember)
                        ? Icon(Icons.account_circle_outlined, color: Colors.grey, size: 5.w)
                        : bloc.userIdSelected.contains(profile.id)
                            ? Icon(Icons.check_box_outlined, color: Colors.black, size: 5.w)
                            : SizedBox(width: 5.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
