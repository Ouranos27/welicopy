import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/chip.dart';
import 'package:weli/fragments/dialog/continue_dialog.dart';
import 'package:weli/fragments/page/default_page.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/profile/page/my-cards/bloc/my_cards_cubit.dart';
import 'package:weli/service/model/entities/card.dart';
import 'package:weli/util/route/app_routing.dart';

class MyCardsPage extends StatefulWidget {
  final String userId;

  const MyCardsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  late MyCardsCubit bloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = MyCardsCubit(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: S.of(context).myProfile,
      scrollable: false,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 25.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1792EA), Color(0xFF21C8D1)]),
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(120.w, 60.w)),
              ),
            ),
          ),
          buildBody(),
        ],
      ),
    );
  }

  Widget buildBody() {
    return BlocBuilder<MyCardsCubit, MyCardsState>(
      buildWhen: (prev, now) => now is MyCardLoaded || now is MyCardLoading,
      bloc: bloc,
      builder: (context, state) {
        if (state is MyCardLoaded) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  ...state.cards.map(card).toList(),
                  SizedBox(height: 30.w),
                ],
              ),
            ),
          );
        }
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: SpinKitThreeBounce(color: AppColor.accentColor, size: 20),
        );
      },
    );
  }

  Widget card(CardData data) {
    return Card(
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
                  padding: const EdgeInsets.only(left: 16, top: 25, bottom: 10),
                  child: Text(
                    data.location ?? '',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: AppFontWeight.semiBold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
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
                  padding: const EdgeInsets.only(left: 12, bottom: 25),
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
            top: 4.w,
            left: 4.w,
            child: actionButton(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (_context) => ContinueDialog(
                    text: '${S.of(context).deleteCard} ?',
                    isRequired: false,
                    onContinue: () async {
                      if (await bloc.deleteCardById('${data.id}')) {
                        await bloc.loadCardsById();
                      }
                    },
                    buttonText: S.of(context).next,
                    bodyChild: SizedBox(height: 10.h),
                  ),
                  barrierDismissible: false,
                );
              },
              iconColor: Colors.black,
              iconData: Icons.delete_outlined,
            ),
          ),
          Positioned(
            top: 4.w,
            right: 4.w,
            child: actionButton(
              onTap: () => Navigator.pushNamed(context, RouteDefine.editCard.name, arguments: data).whenComplete(() {
                return bloc.loadCardsById();
              }),
              iconColor: AppColor.accentColor,
              iconData: Icons.edit,
            ),
          )
        ],
      ),
    );
  }

  Widget actionButton({required VoidCallback onTap, required IconData iconData, required Color iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        padding: const EdgeInsets.all(6),
        child: Icon(iconData, color: iconColor, size: 8.w),
      ),
    );
  }
}
