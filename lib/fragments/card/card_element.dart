import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/chip.dart';
import 'package:weli/service/model/entities/card.dart';

class CardElement extends StatelessWidget {
  final CardData data;

  const CardElement({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      width: 30.w,
      height: 36.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage(data.pictureUrl ?? AppImage.defaultImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 1.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                data.location ?? '',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: AppFontWeight.semiBold,
                    ),
              ),
              SizedBox(width: 1.w),
              if (data.location != null) SvgPicture.asset(AppImage.iconTick, width: 2.w)
            ],
          ),
          Wrap(
            children: [
              MapEntry(const Icon(FontAwesomeIcons.euroSign, size: 8), data.price ?? ''),
              MapEntry(
                Text(
                  "m\u00B2",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 8,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                ),
                data.landArea ?? '',
              ),
              MapEntry(
                Text(
                  "€/m\u00B2",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 8,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                ),
                data.pricePerLandArea,
              ),
            ]
                .map(
                  (e) => ChipElement(
                      mini: true,
                      onPressed: () {},
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            e.key,
                            SizedBox(width: 1.w),
                            Text(
                              "${e.value}",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 8, color: AppColor.chipTextColor),
                            )
                          ],
                        ),
                      ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
