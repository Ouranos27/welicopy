import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tcard/tcard.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/profile/page/swipe-card/bloc/home_cubit.dart';
import 'package:weli/service/model/entities/card.dart';
import 'package:weli/service/service_app/service.dart';

import 'card_stack.dart';
import 'detail_card.dart';

class NewSectionWidget extends StatelessWidget {
  const NewSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is SwipeCardLoaded) {
              return CardStack(
                cardList: state.data,
                controller: context.read<HomeCubit>().tCardController,
                onSwipeLeft: (card) {
                  final cardId = "${card.id}";
                  context.read<HomeCubit>().databaseReact(cardId, state: ReactState.dislike);
                },
                onSwipeRight: (card) {
                  final cardId = "${card.id}";
                  context.read<HomeCubit>().databaseReact(cardId, state: ReactState.like);

                  getIt<CustomFunctionService>().sendNotificationChatPeerToPeerTo(
                    [card.userId!],
                    body: S.current.cardLikedNotification,
                    sender: getIt<AuthService>().token?.uid,
                    page: PageLinkAction.anotherProfile,
                  );
                },
                onTap: (card) => showDetailCardData(context, data: card),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        Positioned.fill(
          bottom: -56.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleButton(
                icon: SvgPicture.asset(AppImage.iconDislike, width: 40),
                onPressed: () => context.read<HomeCubit>().tCardController.forward(direction: SwipDirection.Left),
              ),
              SizedBox(width: 6.w),
              CircleButton(
                icon: SvgPicture.asset(AppImage.iconHeart, color: AppColor.iconColor, width: 32),
                onPressed: () => context.read<HomeCubit>().tCardController.forward(direction: SwipDirection.Right),
              ),
            ],
          ),
        )
      ],
    );
  }

  void showDetailCardData(BuildContext context, {required CardData data}) => showModalBottomSheet(
        context: context,
        barrierColor: Colors.black.withOpacity(0.1),
        backgroundColor: Colors.transparent,
        enableDrag: true,
        builder: (_) => DetailCard(data: data, tCardController: context.read<HomeCubit>().tCardController),
      );
}
