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
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: AppScaffold(
        title: S.of(context).myProfile,
        action: CircleButton(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF404040),
          icon: const Icon(Icons.logout, size: 30),
          mini: true,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ContinueDialog(
                  text: '${S.of(context).logout} ?',
                  isRequired: false,
                  onContinue: () async {
                    final authService = getIt<AuthService>();
                    authService.removeToken();
                    await Navigator.pushNamedAndRemoveUntil(context, RouteDefine.login.name, ModalRoute.withName(RouteDefine.login.name));
                  },
                  buttonText: S.of(context).next,
                  bodyChild: SizedBox(height: 10.h),
                );
              },
              barrierDismissible: false,
            );
          },
        ),
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
                  AppRouting.mainNavigationKey.currentState?.popUntil(ModalRoute.withName(RouteDefine.main.name));
                  AppRouting.wildCardNavigationKey.currentState?.popUntil(ModalRoute.withName(RouteDefine.salons.name));
                },
                height: 2.5.h,
                backgroundColor: AppColor.accentColor,
                child: Text(
                  S.of(context).accessToLounge,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: AppFontWeight.semiBold),
                ),
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is MyCardLoaded) {
                  return ProfileCardList(
                    data: state.cards,
                    userId: getIt<AuthService>().token!.uid!,
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: FloatingActionButton(
              heroTag: '',
              onPressed: () {
                Navigator.pushNamed(context, RouteDefine.editProfile.name, arguments: data).whenComplete(
                  () async {
                    await context.read<ProfileCubit>().loadProfile();
                    await context.read<ProfileCubit>().loadMyCards();
                  },
                );
              },
              backgroundColor: Colors.white,
              foregroundColor: AppColor.accentColor,
              child: const Icon(Icons.edit, size: 36),
            ),
          ),
        ),
      ],
    );
  }
}
