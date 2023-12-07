import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/styles.dart';

class MultiSelectFormField extends StatefulWidget {
  final List<String> answers;
  final Color? backgroundItemColor;
  final ValueChanged<List<String>>? onSaved;
  final List<String> initValue;

  const MultiSelectFormField({Key? key, required this.answers, this.onSaved, this.backgroundItemColor, required this.initValue}) : super(key: key);

  @override
  State<MultiSelectFormField> createState() => _MultiSelectFormFieldState();
}

class _MultiSelectFormFieldState extends State<MultiSelectFormField> {
  Map<String, bool> mappedItem = {};
  List<String> selectedItems = [];

  @override
  void initState() {
    selectedItems = widget.initValue;

    mappedItem = Map.fromIterable(widget.answers,
        key: (k) => k.toString(),
        value: (v) {
          if (v != true && v != false) {
            return false;
          } else {
            return v as bool;
          }
        });
    var temp = mappedItem.map((key, value) => MapEntry(key, false));
    selectedItems.forEach((element) {
      temp[element] = true;
    });
    mappedItem = temp;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints: BoxConstraints(minWidth: 80.w, minHeight: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.sp),
          color: const Color(0xFfEFEFEF),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 65.w,
              child: Wrap(
                children: [
                  ...List.generate(
                    selectedItems.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: widget.backgroundItemColor ?? const Color(0xFFB0B0B0).withOpacity(0.5),
                      ),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedItems[index],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppTextStyle.bodyTextStyle.copyWith(fontWeight: FontWeight.w400, color: AppColor.textColor),
                              ),
                            ),
                            SizedBox(width: 1.w),
                            const Icon(Icons.check_box_outlined, color: AppColor.textColor)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
      onTap: () async {
        await showDialog<List<String>>(
              context: context,
              builder: (_) => AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: CupertinoScrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...mappedItem.keys
                            .map(
                              (String key) => StatefulBuilder(
                                builder: (_, StateSetter setState) => CheckboxListTile(
                                  title: Text(key),
                                  value: mappedItem[key],
                                  controlAffinity: ListTileControlAffinity.platform,
                                  onChanged: (value) => setState(() => mappedItem[key] = value!),
                                ),
                              ),
                            )
                            .toList(),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: const ButtonStyle(visualDensity: VisualDensity.comfortable),
                            child: const Text('OK'),
                            onPressed: () {
                              selectedItems.clear();
                              mappedItem.forEach((key, value) {
                                if (value == true) {
                                  selectedItems.add(key);
                                }
                              });
                              widget.onSaved!(selectedItems);
                              Navigator.pop(context, selectedItems);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ).whenComplete(() {
              var temp = mappedItem.map((key, value) => MapEntry(key, false));
              selectedItems.forEach((element) => temp[element] = true);
              mappedItem = temp;
            }) ??
            [];
      },
    );
  }
}
