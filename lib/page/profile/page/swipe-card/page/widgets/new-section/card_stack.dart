import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tcard/tcard.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/chip.dart';
import 'package:weli/service/model/entities/card.dart';

class CardStack extends StatelessWidget {
  final List<CardData> cardList;

  final ValueChanged<CardData>? onSwipeRight;
  final ValueChanged<CardData>? onSwipeLeft;
  final ValueChanged<CardData>? onTap;
  final TCardController? controller;

  const CardStack({
    required this.cardList,
    this.controller,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cardList.isEmpty) return const SizedBox();

    return TCard(
      controller: controller,
      onForward: (index, info) {
        switch (info.direction) {
          case SwipDirection.Left:
            onSwipeLeft?.call(cardList[info.cardIndex]);
            break;
          case SwipDirection.Right:
            onSwipeRight?.call(cardList[info.cardIndex]);
            break;
          case SwipDirection.None:
            break;
        }
      },
      size: Size(90.w, 120.w),
      cards: cardList.asMap().entries.map(
        (e) {
          final data = e.value, index = e.key;
          final imageBackgroundUrl = data.pictureUrl ?? AppImage.defaultImageUrl;

          return GestureDetector(
            onTap: () => onTap?.call(e.value),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33.0),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                        spreadRadius: -13.0,
                        color: AppColor.dropShadowColor,
                      )
                    ],
                    image: DecorationImage(
                      image: NetworkImage(imageBackgroundUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 2.w),
                            Text(
                              data.location ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white, fontWeight: AppFontWeight.semiBold, fontSize: 20),
                            ),
                            SizedBox(width: 1.w),
                            SvgPicture.asset(AppImage.iconTick, width: 20),
                          ],
                        ),
                        Wrap(
                          children: [
                            MapEntry(const Icon(FontAwesomeIcons.euroSign, size: 14), data.price),
                            MapEntry(
                              Text(
                                "m\u00B2",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      fontWeight: AppFontWeight.semiBold,
                                    ),
                              ),
                              data.livingSpace,
                            ),
                            MapEntry(
                              Text(
                                "€/m\u00B2",
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                      fontWeight: AppFontWeight.semiBold,
                                    ),
                              ),
                              data.pricePerSquareMeters,
                            ),
                            MapEntry(const SizedBox(), data.stateOfGoods),
                          ]
                              .map(
                                (e) => ChipElement(
                                    color: Colors.white,
                                    onPressed: () {},
                                    child: IntrinsicWidth(
                                      child: Row(
                                        children: [
                                          e.key,
                                          SizedBox(width: 1.w),
                                          Text(
                                            "${e.value}",
                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                  fontSize: 14,
                                                  color: AppColor.chipTextColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    )),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -2.4.w,
                  top: -2.w,
                  child: SvgPicture.asset(AppImage.cardBanner, width: 20.w),
                )
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
