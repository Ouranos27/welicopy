import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/data.dart';
import 'package:weli/config/style/styles.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/main.dart';
import 'package:weli/page/register/bloc/register_cubit.dart';
import 'package:weli/service/service_app/function_service.dart';
import 'package:weli/util/route/app_routing.dart';
import 'package:weli/util/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ValueNotifier<double> _counter = ValueNotifier<double>(0);
  TextEditingController controller = TextEditingController();
  final fbKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _counter = ValueNotifier<double>(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            EasyLoading.dismiss();
            Navigator.pushNamedAndRemoveUntil(context, RouteDefine.main.name, ModalRoute.withName(RouteDefine.main.name), arguments: true);
            // id room Weli (room that members can't leave)
            getIt<CustomFunctionService>().addThisUserToDefaultSalon(AppData.weliDefaultRoomId);
            final investmentTypes = state.investmentType;
            investmentTypes.map((e) async {
              final defaultRoomId = getIt<CustomFunctionService>().getSalonIdByName(e);
              return getIt<CustomFunctionService>().addThisUserToDefaultSalon(await defaultRoomId);
            }).toList();
            // guSKdonraw7NcmrYTufk Weli
          }
          if (state is RegisterLoading) {
            EasyLoading.show();
          }
          if (state is RegisterFailed) {
            EasyLoading.dismiss();
            Utils.showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: AppScaffold(
              title: 'Inscription',
              isBack: true,
              body: buildBody(context),
              bottomWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.5.h),
                child: progressBar(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addImage(context, context.read<RegisterCubit>()),
            SizedBox(
              width: 80.w,
              child: FormBuilder(
                key: fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormElement(
                      title: S.of(context).email,
                      isRequired: true,
                      name: 'email',
                      type: FieldType.textField,
                      hintText: 'exemple@mail.com',
                      onChanged: (value) => calculateProgress(context),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.email( errorText: S.of(context).invalid_email),
                          FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                        ],
                      ),
                    ),
                    FormElement(
                      title: S.of(context).password,
                      isRequired: true,
                      name: 'password',
                      type: FieldType.password,
                      hintText: 'XXXXXXXX',
                      onChanged: (value) => calculateProgress(context),
                      validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                    ),
                    FormElement(
                      title: S.of(context).password2,
                      isRequired: true,
                      name: 'passwordConfirmation',
                      onChanged: (value) => calculateProgress(context),
                      type: FieldType.password,
                      hintText: 'XXXXXXXX',
                      validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
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
                            onChanged: (value) => calculateProgress(context),
                            hintText: 'Jean',
                            validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ),
                        ),
                        SizedBox(
                          width: 38.w,
                          child: FormElement(
                            title: S.of(context).lastName,
                            isRequired: true,
                            name: 'lastName',
                            onChanged: (value) => calculateProgress(context),
                            type: FieldType.textField,
                            hintText: 'Dupont',
                            validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ),
                        ),
                      ],
                    ),
                    FormElement(
                      title: S.of(context).phoneNumber,
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
                      isRequired: true,
                      name: 'phoneNumber',
                      onChanged: (value) => calculateProgress(context),
                      type: FieldType.number,
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
                            isRequired: true,
                            name: 'city',
                            type: FieldType.textField,
                            hintText: 'Bordeaux',
                            onChanged: (value) => calculateProgress(context),
                            validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                          ),
                        ),
                        SizedBox(
                          width: 38.w,
                          child: FormElement(
                            title: S.of(context).department,
                            isRequired: true,
                            name: 'department',
                            onChanged: (value) => calculateProgress(context),
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
                      name: 'entreprise',
                      onChanged: (value) => calculateProgress(context),
                      type: FieldType.textField,
                      hintText: 'ASLAND',
                    ),
                    title(title: S.of(context).other),
                    title(title: S.of(context).investmentType, isRequired: true),
                    FormElement(
                      name: 'investment',
                      type: FieldType.multipleChoice,
                      isRequired: true,
                      validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                      onChanged: (value) => calculateProgress(context),
                      itemsMultiChoice: AppData.typeInvestment,
                      backgroundItemsMultiChoiceColor: const Color.fromRGBO(148, 218, 223, 1),
                    ),
                    title(title: S.of(context).job, isRequired: true),
                    FormElement(
                      name: 'job',
                      type: FieldType.select,
                      controller: controller,
                      isRequired: true,
                      itemsMultiChoice: AppData.industry,
                      onChanged: (value) => calculateProgress(context),
                    ),
                    title(title: S.of(context).goods, isRequired: true),
                    FormElement(
                      name: 'goods',
                      isRequired: true,
                      type: FieldType.multipleChoice,
                      onChanged: (value) => calculateProgress(context),
                      itemsMultiChoice: AppData.goods,
                    ),
                    FormBuilderCheckbox(
                      name: "t&c",
                      title: Text.rich(TextSpan(
                        text: S.current.t_and_c_text,
                        children: [
                          const TextSpan(text: " "),
                          TextSpan(
                            text: "CGU",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: AppColor.accentColor,
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch("https://weli.immo/cgu"),
                          ),
                        ],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.textColor,
                            ),
                      )),
                      onChanged: (value) => calculateProgress(context),
                      validator: FormBuilderValidators.equal(true, errorText: S.of(context).empty_field_error),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CommonButton(
                        onPressed: () async {
                          final cubit = context.read<RegisterCubit>();
                          final validateForm = fbKey.currentState?.saveAndValidate();
                          final data = fbKey.currentState!.value;
                          if (validateForm != null && validateForm) {
                            if (cubit.imageFile.path == '') {
                              Utils.showErrorSnackBar(context, S.of(context).requirePhoto);
                            } else {
                              await cubit.register(data);
                            }
                          }
                        },
                        backgroundColor: AppColor.accentColor,
                        width: 25.w,
                        height: 3.5.h,
                        radius: 13,
                        child: Text(
                          S.of(context).next,
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

  Widget title({required String title, bool isRequired = false}) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Text.rich(
        TextSpan(
          text: "$title ",
          children: [
            if (isRequired)
              TextSpan(
                text: "*",
                style: AppTextStyle.bodyTextStyle.copyWith(
                  color: AppColor.redColor,
                  fontWeight: FontWeight.w600,
                ),
              )
          ],
        ),
        style: AppTextStyle.bodyTextStyle.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget progressBar() {
    return Container(
      width: 80.w,
      height: 2.5.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFE4F7FF),
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(color: AppColor.accentColor),
      ),
      child: ValueListenableBuilder<double>(
        builder: (BuildContext context, double value, Widget? child) {
          return AnimatedContainer(
            decoration: BoxDecoration(
              color: AppColor.accentColor,
              borderRadius: BorderRadius.circular(10.sp),
              gradient: const LinearGradient(colors: [Color(0xFF1792EA), Color(0xFF21C8D1)]),
            ),
            width: _counter.value,
            duration: const Duration(milliseconds: 500),
          );
        },
        valueListenable: _counter,
      ),
    );
  }

  Widget addImage(BuildContext context, RegisterCubit cubit) {
    return BlocBuilder(
      bloc: context.read<RegisterCubit>(),
      builder: (context, state) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          await cubit.onImageButtonPressed(ImageSource.gallery, context: context).then((value) {
            calculateProgress(context);
          });
        },
        child: Container(
          width: 35.w,
          height: 35.w,
          margin: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF1999E6), width: cubit.imageFile.path != '' ? 0 : 2),
            color: Colors.white,
          ),
          child: cubit.imageFile.path != ''
              ? ClipRRect(borderRadius: BorderRadius.circular(180), child: Image.file(File(cubit.imageFile.path), fit: BoxFit.cover))
              : Icon(Icons.add, color: const Color(0xFF1999E6), size: 15.w),
        ),
      ),
    );
  }

  void calculateProgress(BuildContext context) {
    var bloc = context.read<RegisterCubit>();
    var email = fbKey.currentState?.fields['email']?.value;
    var password = fbKey.currentState?.fields['password']?.value;
    var passwordConfirmation = fbKey.currentState?.fields['passwordConfirmation']?.value;
    var firstName = fbKey.currentState?.fields['firstName']?.value;
    var lastName = fbKey.currentState?.fields['lastName']?.value;
    var phoneNumber = fbKey.currentState?.fields['phoneNumber']?.value;
    var city = fbKey.currentState?.fields['city']?.value;
    var department = fbKey.currentState?.fields['department']?.value;
    var entreprise = fbKey.currentState?.fields['entreprise']?.value;
    var investment = (fbKey.currentState?.fields['investment']!.value as List?)?.cast<String>();
    var job = fbKey.currentState?.fields['job']?.value;
    var goods = (fbKey.currentState?.fields['goods']?.value as List?)?.cast<String>();
    var t_and_c = fbKey.currentState?.fields['t&c']?.value;
    double progress = 0;
    // total 80.w
    // check if each field is filled
    if (email != null && email != '') {
      progress += 10.w;
    }
    if (password != null && password != '') {
      progress += 7.5.w;
    }
    if (passwordConfirmation != null && passwordConfirmation != '') {
      progress += 7.5.w;
    }
    if (firstName != null && firstName != '') {
      progress += 5.w;
    }
    if (lastName != null && lastName != '') {
      progress += 5.w;
    }
    if (phoneNumber != null && phoneNumber != '') {
      progress += 5.w;
    }
    if (city != null && city != '') {
      progress += 5.w;
    }
    if (department != null && department != '') {
      progress += 4.w;
    }
    if (entreprise != null && entreprise != '') {
      progress += 4.w;
    }
    if (investment != null && investment.isNotEmpty) {
      progress += 4.w;
    }
    if (job != null && job.isNotEmpty) {
      progress += 4.w;
    }
    if (goods != null && goods.isNotEmpty) {
      progress += 4.w;
    }
    if (bloc.imageFile.path != '') {
      progress += 10.w;
    }
    if (t_and_c != null && t_and_c) {
      progress += 5.w;
    }
    _counter.value = progress;
  }
}
