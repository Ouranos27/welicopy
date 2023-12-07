import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  late final double width;
  final double height;
  final double radius;

  CommonButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor = AppColor.accentColor,
    this.radius = 30,
    double? width,
    double? height,
  })  : height = height ?? 4.h,
        width = width ?? 40.w;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius.sp)),
        ),
        onPressed: onPressed,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: child,
        ),
      );
}

class CircleButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final bool mini;

  const CircleButton({
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.foregroundColor,
    this.padding,
    this.mini = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: FloatingActionButton(
        onPressed: onPressed,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        heroTag: key,
        mini: mini,
        child: icon,
      ),
    );
  }
}
