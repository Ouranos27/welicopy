import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/font_weight.dart';
import 'package:weli/fragments/dialog/continue_dialog.dart';
import 'package:weli/fragments/form/form_elements.dart';
import 'package:weli/fragments/search_bar.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/page/salons/bloc/salons_cubit.dart';
import 'package:weli/page/salons/page/widgets/contact_list.dart';
import 'package:weli/service/service_app/function_service.dart';

class CreateSalon extends StatefulWidget {
  const CreateSalon({Key? key}) : super(key: key);

  @override
  State<CreateSalon> createState() => _CreateSalonState();
}

class _CreateSalonState extends State<CreateSalon> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showDialog(context: context, builder: (_) => _selectUserDialog(context), barrierDismissible: false);
      },
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.accentColor, width: 2),
        ),
        margin: EdgeInsets.only(bottom: 3.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 2.w,
              child: Row(
                children: [
                  Container(
                    width: 20.w,
                    child: Text(
                      S.of(context).createSalon,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: AppColor.accentColor, fontWeight: AppFontWeight.semiBold, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const FaIcon(FontAwesomeIcons.crown, color: AppColor.accentColor),
                ],
              ),
            ),
            const Icon(Icons.add, size: 36, color: AppColor.accentColor)
          ],
        ),
      ),
    );
  }

  Widget _selectUserDialog(BuildContext context) {
    var bloc = context.read<SalonsCubit>();
    bloc.userList.clear();
    bloc.userIdSelected = [bloc.userToken!.uid!];
    return ContinueDialog(
      text: S.of(context).inviteParticipants,
      onContinue: () {
        if (bloc.userIdSelected.length > 1) {
          showDialog(context: context, builder: (_) => _nameTheRoom(context), barrierDismissible: false);
        }
      },
      buttonText: S.of(context).next,
      bodyChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            SearchBarWeli(
              hintText: 'example@gmail.com',
              name: "search",
              validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
              onChanged: (value) {
                if (value != null && value != '') {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    bloc.searchUserByEmail(value);
                  });
                }
              },
            ),
            BlocBuilder(
              buildWhen: (pre, now) => now is UserSearched || now is UserSearching,
              bloc: bloc,
              builder: (context, state) {
                if (state is UserSearching) {
                  return const Padding(padding: EdgeInsets.all(15), child: CircularProgressIndicator());
                }
                return Container(
                  constraints: BoxConstraints(maxHeight: 55.h),
                  child: ContactList(contactList: bloc.userList, bloc: bloc),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameTheRoom(BuildContext context) {
    var bloc = context.read<SalonsCubit>();
    bloc.userList.clear();
    var _fbKey = GlobalKey<FormBuilderState>();
    return BlocBuilder(
        bloc: bloc,
        buildWhen: (pre, now) => now is SalonCreated || now is SalonCreating,
        builder: (context, state) {
          if (state is SalonCreating) {
            return const Center(child: CircularProgressIndicator());
          }
          return ContinueDialog(
            text: S.of(context).nameTheRoom,
            onContinue: () async {
              if (_fbKey.currentState!.saveAndValidate()) {
                var params = {
                  ..._fbKey.currentState!.value,
                  'members': bloc.userIdSelected,
                  "type": ChatroomMessageType.customizeRoom.name,
                  "createdAt": Timestamp.now(),
                  'creator': bloc.userToken!.uid,
                };
                if (await bloc.createSalon(params)) {
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
                      return AlertDialog(
                        content: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            S.current.createSalonSuccess.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: AppColor.accentColor,
                                  fontWeight: AppFontWeight.semiBold,
                                  fontSize: 20,
                                ),
                          ),
                        ),
                      );
                    },
                  );
                  await getIt<CustomFunctionService>().sendNotificationChatPeerToPeerTo(bloc.userIdSelected, body: S.of(context).invitedNotification);
                }
              }
            },
            buttonText: S.of(context).next,
            bodyChild: FormBuilder(
              key: _fbKey,
              child: SizedBox(
                width: 80.w,
                child: FormElement(
                  isRequired: true,
                  name: 'name',
                  type: FieldType.textField,
                  hintText: 'Keller',
                  validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                ),
              ),
            ),
          );
        });
  }
}
