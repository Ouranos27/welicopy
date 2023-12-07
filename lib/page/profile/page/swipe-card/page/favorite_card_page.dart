import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/profile/page/swipe-card/bloc/home_cubit.dart';
import 'package:weli/page/profile/page/swipe-card/page/widgets/favorite-section/favorite_section.dart';
import 'package:weli/util/route/app_routing.dart';

class FavoriteCardPage extends StatelessWidget {
  final String uId;

  const FavoriteCardPage({
    required this.uId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => HomeCubit(uId, isFavoriteCard: true),
      child: AppScaffold(
        title: S.of(context).favoriteSection,
        scrollable: false,
        action: UserIconButton(
          onPressed: () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 20.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1792EA), Color(0xFF21C8D1)],
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(70.w, 28.w)),
                ),
              ),
            ),
            SizedBox.expand(
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: const FavoriteSectionWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
