import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/image.dart';
import 'package:weli/fragments/fragments.dart';
import 'package:weli/generated/l10n.dart';
import 'package:weli/page/forgot-password/bloc/forgot_password_cubit.dart';
import 'package:weli/util/utils.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            EasyLoading.dismiss();
            Utils.showErrorSnackBar(context, state.message);
          }
          if (state is ForgotPasswordLoading) {
            EasyLoading.show();
          }
          if (state is ForgotPasswordFailed) {
            EasyLoading.dismiss();
            Utils.showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: AppScaffold(
              body: buildBody(context),
              title: S.of(context).forgotPasswordTitle,
              isBack: true,
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.weliBanner,
                width: 60.w,
              ),
              Text(
                "We love invest",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: const Color(0xFF1897E8),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 80.w,
                child: FormBuilder(
                  key: context.read<ForgotPasswordCubit>().fbKey,
                  child: FormElement(
                    title: S.of(context).email,
                    isRequired: true,
                    name: 'user_name',
                    type: FieldType.textField,
                    hintText: 'exemple@mail.com',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.email(errorText: S.of(context).invalid_email),
                        FormBuilderValidators.required(errorText: S.of(context).empty_field_error),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 70.w,
                child: Text(
                  S.of(context).resetPasswordMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.subTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              SizedBox(height: 2.h),
              CommonButton(
                onPressed: () async {
                  var bloc = context.read<ForgotPasswordCubit>();
                  var validateForm = bloc.fbKey.currentState?.saveAndValidate();
                  if (validateForm != null && validateForm) {
                    await bloc.forgotPassword();
                  }
                },
                backgroundColor: AppColor.accentColor,
                width: 30.w,
                height: 4.h,
                radius: 13,
                child: Text(
                  S.of(context).send,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: const Color(0xFF072B53),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
}
