import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/page/message/bloc/message_cubit.dart';

class FormMessageInput extends StatefulWidget {
  const FormMessageInput({Key? key}) : super(key: key);

  @override
  State<FormMessageInput> createState() => _FormMessageInputState();
}

class _FormMessageInputState extends State<FormMessageInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8.w),
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: AppColor.hintTextColor),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.redColor, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.redColor, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.borderColor, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.borderColor, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            filled: true,
            fillColor: const Color(0xFfEFEFEF),
          ),
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  context.read<MessageCubit>().sendMessage(_controller.text);
                  _controller.clear();
                }
              },
              icon: const Icon(Ionicons.arrow_forward, size: 32, color: AppColor.accentColor),
            ),
          ),
        ),
      ),
    );
  }
}
