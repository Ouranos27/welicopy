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
import 'package:weli/main.dart';
import 'package:weli/page/login/bloc/login_cubit.dart';
import 'package:weli/service/service_app/function_service.dart';
import 'package:weli/util/route/app_routing.dart';
import 'package:weli/util/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, RouteDefine.main.name, arguments: true);
            getIt<CustomFunctionService>().saveDeviceTokenToFirebase();
          }
          if (state is LoginLoading) {
            EasyLoading.show();
          }
          if (state is LoginFailed) {
            EasyLoading.dismiss();
            Utils.showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) => AppScaffold(
          title: S.of(context).connection,
          isBack: false,
          body: buildBody(context),
          bottomWidget: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 24),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.pushNamed(context, RouteDefine.register.name);
              },
              child: Text(
                S.of(context).register,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColor.accentColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImage.weliBanner, width: 70.w),
          Text(
            S.of(context).loginTitleDescription,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: const Color(0xFF1897E8),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: 80.w,
            child: FormBuilder(
              key: context.read<LoginCubit>().fbKey,
              child: Column(
                children: [
                  FormElement(
                    title: S.of(context).email,
                    isRequired: true,
                    name: 'user_name',
                    type: FieldType.textField,
                    hintText: 'exemple@mail.com',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.email(errorText: S.of(context).invalid_email),
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
                    validator: FormBuilderValidators.required( errorText: S.of(context).empty_field_error),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pushNamed(context, RouteDefine.forgotPassword.name);
            },
            child: Text(
              S.of(context).forgotPassword,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColor.accentColor,
                  ),
            ),
          ),
          SizedBox(height: 2.h),
          CommonButton(
            onPressed: () async {
              var bloc = context.read<LoginCubit>();

              var validateForm = bloc.fbKey.currentState?.saveAndValidate();

              if (validateForm != null && validateForm) {
                await bloc.login();
              }
            },
            backgroundColor: AppColor.accentColor,
            width: 30.w,
            height: 4.h,
            radius: 13,
            child: Text(
              S.of(context).login,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: const Color(0xFF072B53),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      );
}
