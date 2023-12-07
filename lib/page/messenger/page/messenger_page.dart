import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/messenger/bloc/messenger_cubit.dart';
import 'package:weli/page/messenger/page/widgets/customize_message_result_list.dart';
import 'package:weli/page/messenger/page/widgets/private_message_result_list.dart';
import 'package:weli/util/route/app_routing.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key}) : super(key: key);

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final bloc = MessengerCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: AppScaffold(
        isBack: false,
        action: UserIconButton(
          onPressed: () => AppRouting.mainNavigationKey.currentState?.pushNamed(RouteDefine.mainProfile.name),
        ),
        title: S.of(context).messenger,
        body: Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              SearchBarWeli(
                hintText: S.of(context).searchContact,
                onChanged: (value) {
                  if (value != null) bloc.searchSalon(value);
                },
                name: 'search',
              ),
              const PrivateMessageResultList(),
              const CustomizeRoomMessageResultList(),
              // buildSalonList(),
            ],
          ),
        ),
      ),
    );
  }
}
