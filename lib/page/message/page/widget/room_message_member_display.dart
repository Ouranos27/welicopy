import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/bloc/message_cubit.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';
import 'package:weli/util/utils.dart';

class RoomMessageMemberDisplay extends StatelessWidget {
  const RoomMessageMemberDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      buildWhen: (prev, now) => now is AllProfilesLoaded,
      builder: (context, state) {
        if (state is AllProfilesLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                    child: Text(
                      Utils.numberCountWithLimit(state.profiles.length),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          final uId = state.profiles[index].id;
                          if (uId != getIt<AuthService>().token?.uid) {
                            AppRouting.mainNavigationKey.currentState
                                ?.pushNamed(RouteDefine.anotherProfile.name, arguments: state.profiles[index].id);
                          } else {
                            AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name, arguments: state.profiles[index].id);
                          }
                        },
                        child: ProfileAvatar(
                          size: 60,
                          pictureUrl: state.profiles[index].pictureUrl,
                          fontSize: 35,
                          firstName: state.profiles[index].firstName,
                        ),
                      ),
                    ),
                    itemCount: state.profiles.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          );
        }

        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: SpinKitThreeBounce(color: AppColor.accentColor, size: 20),
        );
      },
    );
  }
}
