import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/data.dart';
import 'package:weli/config/style/styles.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/profile/page/edit-profile/bloc/edit_profile_cubit.dart';
import 'package:weli/service/model/entities/profile.dart';
import 'package:weli/util/utils.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            EasyLoading.dismiss();
            Navigator.pop(context);
          }
          if (state is EditProfileLoading) {
            EasyLoading.show();
          }
          if (state is EditProfileFailed) {
            EasyLoading.dismiss();
            Utils.showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: AppScaffold(
              title: S.current.myAccount,
              isBack: true,
              body: buildBody(context, widget.profile),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, Profile data) {
    return DecoratedBox(
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addImage(context, context.read<EditProfileCubit>()),
            SizedBox(
              width: 80.w,
              child: FormBuilder(
                key: context.read<EditProfileCubit>().fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormElement(
                      title: S.of(context).email,
                      isRequired: true,
                      name: 'user_name',
                      type: FieldType.textField,
                      hintText: 'example@gmail.com',
                      initialValue: data.email,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.email( errorText: S.of(context).invalid_email),
                          FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 38.w,
                          child: FormElement(
                            title: S.of(context).firstName,
                            isRequired: true,
                            name: 'firstName',
                            type: FieldType.textField,
                            hintText: 'Jean',
                            initialValue: data.firstName,
                            validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ),
                        ),
                        SizedBox(
                          width: 38.w,
                          child: FormElement(
                            title: S.of(context).lastName,
                            isRequired: true,
                            name: 'lastName',
                            type: FieldType.textField,
                            initialValue: data.lastName,
                            hintText: 'Dupont',
                            validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ),
                        ),
                      ],
                    ),
                    FormElement(
                      title: S.of(context).phoneNumber,
                      isRequired: true,
                      name: 'phoneNumber',
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: "@! ## ## ## ##",
                          filter: {
                            "@": RegExp(r'0'),
                            "!": RegExp(r'[6,7]'),
                            "#": RegExp(r'[0-9]'),
                          },
                          type: MaskAutoCompletionType.lazy,
                        ),
                      ],
                      type: FieldType.number,
                      initialValue: data.phoneNumber,
                      hintText: '06 00 00 00 00',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 38.w,
                          child: FormElement(
                            title: S.of(context).city,
                            initialValue: data.city,
                            isRequired: true,
                            name: 'city',
                            type: FieldType.textField,
                            hintText: 'Bordeaux',
                            validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ),
                        ),
                        SizedBox(
                          width: 38.w,
                          child: FormElement(
                            title: S.of(context).department,
                            initialValue: data.department,
                            isRequired: true,
                            name: 'department',
                            type: FieldType.number,
                            maxLength: 5,
                            hintText: '33000',
                            validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ),
                        ),
                      ],
                    ),
                    FormElement(
                      title: S.of(context).company,
                      isRequired: false,
                      name: 'entreprise',
                      initialValue: data.entreprise,
                      type: FieldType.textField,
                      hintText: 'ASLAND',
                    ),
                    title(title: S.of(context).other),
                    title(title: S.of(context).investmentType),
                    FormElement<List<String>?>(
                      name: 'investment',
                      type: FieldType.multipleChoice,
                      initialValue: data.investment,
                      itemsMultiChoice: AppData.typeInvestment,
                      backgroundItemsMultiChoiceColor: const Color.fromRGBO(148, 218, 223, 1),
                    ),
                    title(title: S.of(context).job),
                    FormElement<String?>(
                      name: 'job',
                      type: FieldType.select,
                      controller: controller,
                      initialValue: data.job,
                      itemsMultiChoice: AppData.industry,
                    ),
                    title(title: S.of(context).goods),
                    FormElement<List<String>?>(
                      name: 'goods',
                      type: FieldType.multipleChoice,
                      itemsMultiChoice: AppData.goods,
                      initialValue: data.goods,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CommonButton(
                        onPressed: () async {
                          var cubit = context.read<EditProfileCubit>();
                          var validateForm = cubit.fbKey.currentState?.saveAndValidate();
                          var formValue = {...cubit.fbKey.currentState!.value, 'pictureUrl': widget.profile.pictureUrl};
                          if (validateForm != null && validateForm) {
                            await cubit.editProfile(formValue);
                          }
                        },
                        backgroundColor: AppColor.accentColor,
                        width: 25.w,
                        height: 3.5.h,
                        radius: 13,
                        child: Text(
                          S.of(context).modify,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: const Color(0xFF072B53),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget title({required String title}) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Text(
        title,
        style: AppTextStyle.bodyTextStyle.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget addImage(BuildContext context, EditProfileCubit cubit) {
    return BlocBuilder(
      bloc: context.read<EditProfileCubit>(),
      builder: (context, state) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          await cubit.onImageButtonPressed(ImageSource.gallery, context: context);
        },
        child: Container(
          width: 35.w,
          height: 35.w,
          margin: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF1999E6),
              width: widget.profile.pictureUrl != null ? 1 : 0,
            ),
            color: widget.profile.pictureUrl != null ? Colors.white : const Color(0xFFBBDEFB),
          ),
          child: cubit.imageFile != null && cubit.imageFile!.path != ''
              ? ClipRRect(borderRadius: BorderRadius.circular(180), child: Image.file(File(cubit.imageFile!.path), fit: BoxFit.cover))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child: widget.profile.pictureUrl != null
                      ? CachedNetworkImage(imageUrl: widget.profile.pictureUrl!, fit: BoxFit.cover)
                      : Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${widget.profile.firstName}"[0],
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 48, color: Colors.blueAccent),
                            maxLines: 1,
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
