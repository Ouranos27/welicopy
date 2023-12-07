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
import 'package:weli/util/route/app_routing.dart';

class PrivateMessageResultList extends StatelessWidget {
  const PrivateMessageResultList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: SizedBox(
        height: 24.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).privateMessage,
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
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.privateRooms.length,
                      itemBuilder: (context, index) {
                        final user = state.profilePrivateRooms[index];
                        return GestureDetector(
                          onTap: () {
                            getIt<MainBloc>().add(ChangeNavbar(1));
                            Future.delayed(
                              const Duration(milliseconds: 50),
                              () => AppRouting.wildCardNavigationKey.currentState?.pushNamed(
                                RouteDefine.privateMessage.name,
                                arguments: user.id,
                              ),
                            );
                          },
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: ProfileAvatar(
                              size: 45,
                              pictureUrl: user.pictureUrl,
                              firstName: user.firstName,
                            ),
                            title: Text(
                              "${user.firstName} ${user.lastName}",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: AppFontWeight.semiBold,
                                    color: AppColor.textColor,
                                  ),
                            ),
                            subtitle: Text(
                              "${user.job}",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: AppFontWeight.normal,
                                    color: AppColor.textColor,
                                  ),
                            ),
                          ),
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
      ),
    );
  }
}
