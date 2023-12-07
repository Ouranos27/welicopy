import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/main/bloc/main_bloc.dart';
import 'package:weli/page/profile/bloc/profile_cubit.dart';
import 'package:weli/page/profile/page/widgets/profile_card_list.dart';
import 'package:weli/page/profile/page/widgets/profile_detail.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/util/route/app_routing.dart';

class AnotherProfilePage extends StatelessWidget {
  final String userId;

  const AnotherProfilePage({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(uId: userId),
      child: AppScaffold(
        title: S.of(context).profile,
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          buildWhen: (prev, now) => now is ProfileLoaded,
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return buildBody(context, state.data);
            }

            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, Profile data) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            ProfileDetail(
              data: data,
              actionButton: CommonButton(
                onPressed: () {
                  getIt<MainBloc>().add(ChangeNavbar(1));

                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      AppRouting.mainNavigationKey.currentState?.popUntil(ModalRoute.withName(RouteDefine.main.name));
                      AppRouting.wildCardNavigationKey.currentState?.pushNamed(
                        RouteDefine.privateMessage.name,
                        arguments: userId,
                      );
                    },
                  );
                },
                height: 2.5.h,
                width: 30.w,
                backgroundColor: AppColor.accentColor,
                child: Text(
                  S.of(context).messenger,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: AppFontWeight.semiBold),
                ),
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is MyCardLoaded) {
                  return ProfileCardList(data: state.cards, editable: false, userId: userId);
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ],
    );
  }
}
