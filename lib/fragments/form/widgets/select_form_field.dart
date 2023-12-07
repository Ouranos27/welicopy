import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/styles.dart';

class SelectFormField extends StatefulWidget {
  final List<String> items;
  final Color? backgroundItemColor;
  final ValueChanged<String> onSaved;
  final String? initValue;

  const SelectFormField({Key? key, required this.items, required this.onSaved, this.backgroundItemColor, this.initValue}) : super(key: key);

  @override
  _SelectFormFieldState createState() => _SelectFormFieldState();
}

class _SelectFormFieldState extends State<SelectFormField> {
  late String selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    selectedItem = widget.initValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: "",
      itemBuilder: (_) {
        return [
          PopupMenuItem(
            child: Container(
                width: 60.w,
                height: 25.h,
                padding: EdgeInsets.only(bottom: 1.h),
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: widget.items.length,
                    itemBuilder: (BuildContext context, int index) => GestureDetector(
                      onTap: () {
                        selectedItem = widget.items[index];
                        widget.onSaved(widget.items[index]);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.borderColor, width: 0.5))),
                        child: Text(widget.items[index]),
                      ),
                    ),
                  ),
                )),
          ),
        ];
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 80.w, minHeight: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.sp),
          color: const Color(0xFfEFEFEF),
        ),
        child: Row(
          children: [
            if (selectedItem != "")
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: widget.backgroundItemColor ?? const Color(0xFFB0B0B0).withOpacity(0.5),
                ),
                child: Text(
                  selectedItem,
                  style: AppTextStyle.bodyTextStyle.copyWith(fontWeight: FontWeight.w400, color: AppColor.textColor),
                ),
              ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}
