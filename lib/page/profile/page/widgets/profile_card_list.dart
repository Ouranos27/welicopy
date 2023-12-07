import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/fragments/card/card_element.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/profile/bloc/profile_cubit.dart';
import 'package:weli/service/model/entities/card.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';

class ProfileCardList extends StatelessWidget {
  final bool editable;
  final String userId;
  final List<CardData> data;

  const ProfileCardList({
    this.editable = true,
    required this.data,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              children: [
                if (editable)
                  FloatingActionButton(
                    onPressed: () {
                      if (editable) {
                        AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.favouriteCard.name, arguments: userId);
                      }
                    },
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(AppImage.iconHeart, color: AppColor.iconColor),
                  )
                else
                  SizedBox(height: 6.h),
                SizedBox(height: 3.w),
                Text(S.of(context).cardAvailableCount(data.length), style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 36.w,
          child: GestureDetector(
            onTap: () async {
              final uId = getIt<AuthService>().token?.uid;
              if (userId == uId) {
                await AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.myCards.name, arguments: userId);
              } else {
                await AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.swipeCard.name, arguments: userId);
              }

              await context.read<ProfileCubit>().loadCardsById(userId);
            },
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 4.w),
              children: [
                if (editable)
                  SizedBox(
                    width: 30.w,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteDefine.createCard.name).whenComplete(() {
                          context.read<ProfileCubit>().loadCardsById(userId);
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        side: const BorderSide(color: AppColor.accentColor, width: 2),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Icon(Icons.add, size: 36),
                    ),
                  ),
                if (editable) SizedBox(width: 3.w),
                ...data.map(
                  (e) => CardElement(data: e),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
