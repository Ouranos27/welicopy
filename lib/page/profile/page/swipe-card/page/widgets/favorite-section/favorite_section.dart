import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/buttons.dart';
import 'package:weli/fragments/chip.dart';
import 'package:weli/fragments/dialog/yes_no_dialog.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/profile/page/swipe-card/bloc/home_cubit.dart';
import 'package:weli/service/model/entities/index.dart';
import 'package:weli/util/utils.dart';

class FavoriteSectionWidget extends StatelessWidget {
  const FavoriteSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LikeCardRemoved) {
          Utils.showSnackBar(context, S.of(context).success);
          context.read<HomeCubit>().loadFavoriteCards();
        }

        if (state is CardError) {
          Utils.showErrorSnackBar(context, state.error.toString());
        }
      },
      builder: (context, state) {
        if (state is FavoriteCardLoaded) {
          if (state.data.isNotEmpty) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 10.h, top: 4.h),
              child: Column(
                children: state.data.map((e) => card(context, e)).toList(),
              ),
            );
          }

          return Container(
            padding: EdgeInsets.all(10.w),
            child: Text(
              S.current.noCardFavorite,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget card(BuildContext context, CardData data) => Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33))),
        margin: const EdgeInsets.only(bottom: 25),
        elevation: 8,
        shadowColor: AppColor.dropShadowColor,
        child: Stack(
          children: [
            Container(
              width: 85.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(33),
                    child: CachedNetworkImage(imageUrl: data.pictureUrl ?? AppImage.defaultImageUrl, fit: BoxFit.cover, height: 70.w, width: 85.w),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25, bottom: 10),
                    child: Text(
                      data.location ?? '',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: AppFontWeight.semiBold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Wrap(
                      children: data.goods!
                          .map(
                            (e) => ChipElement(
                              onPressed: () {},
                              color: const Color(0xFFFEB42B).withOpacity(0.5),
                              child: IntrinsicWidth(
                                child: Text(
                                  e,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, color: AppColor.chipTextColor),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14, bottom: 25),
                    child: Wrap(
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
                              onPressed: () {},
                              color: const Color(0xFFACE4BF),
                              child: IntrinsicWidth(
                                child: Row(
                                  children: [
                                    e.key,
                                    SizedBox(width: 1.w),
                                    Text(
                                      "${e.value}",
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, color: AppColor.chipTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: -2.4.w,
              top: -2.w,
              child: SvgPicture.asset(AppImage.cardBanner, width: 20.w),
            ),
            Positioned(
              top: 4.w,
              right: 4.w,
              child: CircleButton(
                foregroundColor: Colors.black,
                icon: const Icon(FontAwesomeIcons.solidTrashAlt, size: 28),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => YesNoDialog(
                      S.of(context).remove_like_warning,
                      onYes: () {
                        context.read<HomeCubit>().removeLikeCard("${data.id}");
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );

  Widget actionButton({required VoidCallback onTap, required IconData iconData}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        padding: const EdgeInsets.all(5),
        child: Icon(
          iconData,
          color: AppColor.accentColor,
          size: 10.w,
        ),
      ),
    );
  }
}
