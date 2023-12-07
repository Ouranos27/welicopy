import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tcard/tcard.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/card/card_data.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/service/model/entities/card.dart';
import 'package:weli/service/service_app/service.dart';
import 'package:weli/util/route/app_routing.dart';

class DetailCard extends StatelessWidget {
  final CardData data;
  final TCardController tCardController;

  const DetailCard({
    required this.data,
    required this.tCardController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> moreDetailsText = [
      'Balcon',
      'Ascenseur',
      'Bonne exposition',
      'Sans vis à vis',
      'Piscine',
      'Suite parentale',
      'Cuisine équipée',
      'Coup de coeur',
      'Parking',
      'Neuf'
    ];
    final moreDetailsImg = [
      'balcony',
      'elevator',
      'sun',
      'building',
      'swim',
      'bed',
      'fridge',
      'house',
      'car',
      'new',
    ];
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          top: 20,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(37)),
            ),
            child: DraggableScrollableSheet(
              expand: false,
              maxChildSize: 1,
              minChildSize: 0.8,
              initialChildSize: 1,
              builder: (context, scrollController) {
                return CupertinoScrollbar(
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 1.w),
                                  Text(
                                    "${data.location} (${data.profitability ?? 0})",
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: AppFontWeight.semiBold, fontSize: 20),
                                  ),
                                  SizedBox(width: 1.w),
                                  SvgPicture.asset(AppImage.iconTick, width: 20),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Wrap(
                                children: [
                                  if (data.goods != null) ...data.goods!.map((e) => MapEntry(e, AppColor.chipColorPropertyType)),
                                  if (data.investment != null) ...data.investment!.map((e) => MapEntry(e, AppColor.chipColorInvestmentType)),
                                  if (data.buyerType != null) MapEntry(AppCardData.buyerType[data.buyerType], AppColor.chipColorBuyerType),
                                ]
                                    .map(
                                      (e) => ChipElement(
                                          color: e.value,
                                          child: Text(
                                            "${e.key}",
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontSize: 14,
                                                  color: AppColor.chipTextColor,
                                                ),
                                          )),
                                    )
                                    .toList(),
                              ),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                child: Text(
                                  S.of(context).plus,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              if (data.moreDetails != null)
                                Wrap(
                                  children: (data.moreDetails!).map(
                                    (e) {
                                      final index = moreDetailsText.indexWhere((element) => element == e);
                                      return Container(
                                        width: 25.w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 0.5.h),
                                              child: Image.asset('assets/graphics/card/${moreDetailsImg[index]}.png'),
                                            ),
                                            Text(e, textAlign: TextAlign.center),
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              SizedBox(height: 4.h),
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    CommonButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        final userId = data.userId;
                                        if (userId != getIt<AuthService>().token?.uid) {
                                          AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.anotherProfile.name, arguments: userId);
                                        } else {
                                          AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name, arguments: userId);
                                        }
                                      },
                                      height: 2.5.h,
                                      radius: 10,
                                      backgroundColor: AppColor.accentColor,
                                      child: Text(
                                        S.of(context).redirectToProfile,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: AppFontWeight.semiBold),
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    CommonButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.privateMessage.name, arguments: data.userId);
                                      },
                                      height: 2.5.h,
                                      radius: 10,
                                      backgroundColor: AppColor.accentColor,
                                      child: Text(
                                        S.of(context).contactToSeller,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: AppFontWeight.semiBold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6.h),
                              CarouselWithIndicator(
                                imageSliders: [
                                  data.pictureUrl,
                                  data.pictureUrl,
                                  data.pictureUrl,
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 15.w,
          top: 0,
          child: CircleButton(
            mini: true,
            icon: SvgPicture.asset(AppImage.iconHeart, color: AppColor.iconColor, width: 20),
            onPressed: () {
              Navigator.of(context).pop();
              tCardController.forward(direction: SwipDirection.Right);
            },
          ),
        ),
        Positioned(
          top: 30,
          right: 15,
          child: IconButton(
            icon: SvgPicture.asset(AppImage.iconClose, width: 24),
            onPressed: Navigator.of(context).pop,
          ),
        )
      ],
    );
  }
}
