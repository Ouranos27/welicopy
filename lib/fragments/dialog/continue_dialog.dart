import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/styles.dart';
import 'package:weli/fragments/fragments.dart';

class ContinueDialog extends StatelessWidget {
  final String text;
  final String buttonText;
  final Widget bodyChild;
  final VoidCallback? onContinue;
  final double? buttonWidth;
  final bool isRequired;

  const ContinueDialog({
    Key? key,
    this.onContinue,
    this.buttonWidth,
    this.isRequired = true,
    required this.text,
    required this.buttonText,
    required this.bodyChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(20),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      constraints: BoxConstraints(maxWidth: 58.w),
                      child: Text.rich(
                        TextSpan(
                          text: text,
                          style: const TextStyle(fontSize: 15),
                          children: [
                            if(isRequired)TextSpan(
                              text: " *",
                              style: AppTextStyle.bodyTextStyle.copyWith(
                                color: AppColor.redColor,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        style: AppTextStyle.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.clear, color: Color(0xFF707070))),
                ],
              ),
              bodyChild,
              Align(
                alignment: Alignment.centerRight,
                child: CommonButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onContinue?.call();
                  },
                  backgroundColor: AppColor.accentColor,
                  radius: 13,
                  width: buttonWidth ?? 28.w,
                  child: Text(
                    buttonText,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: const Color(0xFF072B53),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
