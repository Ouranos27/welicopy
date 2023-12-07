import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/page/salons/bloc/salons_cubit.dart';
import 'package:weli/page/salons/page/widgets/salon_card_list.dart';
import 'package:weli/util/route/app_routing.dart';

class SalonsPage extends StatefulWidget {
  const SalonsPage({Key? key}) : super(key: key);

  @override
  State<SalonsPage> createState() => _SalonsPageState();
}

class _SalonsPageState extends State<SalonsPage> {
  final bloc = SalonsCubit();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: AppScaffold(
        title: S.of(context).salon,
        scrollable: true,
        isBack: false,
        action: UserIconButton(onPressed: () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name)),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: SearchBarWeli(
            hintText: S.of(context).searchSalon,
            name: "search",
            onChanged: (value) async {
              if (value != null) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 400), () {
                  bloc.searchSalon(value);
                });
              }
            },
          ),
        ),
        buildSalonList(),
      ],
    );
  }

  Widget buildSalonList() {
    return BlocBuilder<SalonsCubit, SalonsState>(
      bloc: bloc,
      buildWhen: (pre, now) => now is SalonsLoaded || now is SalonsSearching,
      builder: (context, state) {
        if (state is SalonsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, top: 4.w),
                child: Text(
                  S.of(context).defaultSalon,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.accentColor,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 16,
                  ),
                ),
              ),
              SalonCardList(
                listRooms: state.generalRooms,
                creatable: true,
                members: state.profileGeneralRooms,
                roomType: ChatroomMessageType.generalRoom,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  S.of(context).myRooms,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.accentColor,
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: 16,
                      ),
                ),
              ),
              SalonCardList(
                listRooms: state.customizeRooms,
                creatable: false,
                members: state.profileCustomizeRooms,
                roomType: ChatroomMessageType.customizeRoom,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  S.of(context).otherSalons,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.accentColor,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 16,
                  ),
                ),
              ),
              SalonCardList(
                listRooms: state.otherRooms,
                creatable: false,
                members: state.profileOtherRooms,
                roomType: ChatroomMessageType.customizeRoom,
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          );
        }
        return Padding(
          padding: EdgeInsets.all(5.h),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
