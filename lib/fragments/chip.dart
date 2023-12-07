import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChipElement extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final bool isOnImage;
  final bool mini;
  final Widget child;

  const ChipElement({
    required this.child,
    this.onPressed,
    this.isOnImage = false,
    this.mini = false,
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(mini ? 0.5.w : 1.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: isOnImage ? color.withOpacity(0.5) : color,
        ),
        padding: EdgeInsets.all(mini ? 0.75.w : 1.25.w),
        child: child,
      ),
    );
  }
}
