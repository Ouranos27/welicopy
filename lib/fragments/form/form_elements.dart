import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:sizer/sizer.dart';
import 'package:weli/config/colors.dart';
import 'package:weli/config/style/styles.dart';
import 'package:weli/fragments/form/widgets/multi_select_form_field.dart';
import 'package:weli/fragments/form/widgets/select_form_field.dart';
import 'package:weli/generated/l10n.dart';

enum FieldType { textField, password, number, multipleChoice, typeAhead, select, numberInput }

class FormElement<T> extends StatefulWidget {
  final String name;
  final FieldType type;
  final bool isRequired;
  final FocusNode? focusNode;
  final String? title;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final T? initialValue;
  final List<String>? itemsMultiChoice;
  final Color? backgroundItemsMultiChoiceColor;
  final ValueChanged<dynamic>? onChanged;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const FormElement({
    required this.name,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    required this.type,
    this.isRequired = false,
    this.focusNode,
    this.title,
    this.hintText,
    this.validator,
    this.initialValue,
    this.itemsMultiChoice,
    this.backgroundItemsMultiChoiceColor,
    this.maxLength,
  });

  @override
  State<FormElement> createState() => _FormElementState();
}

class _FormElementState extends State<FormElement> {
  bool _showPassword = false;

  void setShowPassword(bool val) => setState(() => _showPassword = val);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: AppColor.hintTextColor),
          errorStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.red),
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
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Container(
                margin: const EdgeInsets.all(4),
                child: Text.rich(
                  TextSpan(
                    text: "${widget.title} ",
                    children: [
                      if (widget.isRequired)
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
              ),
            Builder(
              builder: (context) {
                switch (widget.type) {
                  case FieldType.password:
                    return FormBuilderTextField(
                      maxLines: 1,
                      inputFormatters: widget.inputFormatters,
                      name: widget.name,
                      onChanged: widget.onChanged,
                      textAlign: TextAlign.start,
                      autofillHints: [AutofillHints.password],
                      initialValue: widget.initialValue,
                      keyboardAppearance: Brightness.light,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16, color: Colors.black),
                      focusNode: widget.focusNode,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        suffixIcon: IconButton(
                          icon: _showPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                          onPressed: () => setShowPassword(_showPassword = !_showPassword),
                          color: const Color(0xFFADBBC2),
                        ),
                      ),
                      obscureText: !_showPassword,
                      keyboardType: TextInputType.text,
                      validator: widget.validator,
                    );
                  case FieldType.number:
                    return FormBuilderTextField(
                      maxLines: 1,
                      inputFormatters: widget.inputFormatters,
                      controller: widget.controller,
                      initialValue: widget.initialValue,
                      onChanged: widget.onChanged,
                      name: widget.name,
                      focusNode: widget.focusNode,
                      keyboardAppearance: Brightness.light,
                      maxLength: widget.maxLength,
                      buildCounter:
                          widget.maxLength != null ? (context, {required currentLength, required isFocused, maxLength}) => const SizedBox() : null,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(hintText: widget.hintText),
                      keyboardType: TextInputType.number,
                      validator: widget.validator,
                    );
                  case FieldType.textField:
                    return FormBuilderTextField(
                      maxLines: 1,
                      inputFormatters: widget.inputFormatters,
                      controller: widget.controller,
                      initialValue: widget.initialValue,
                      onChanged: widget.onChanged,
                      name: widget.name,
                      focusNode: widget.focusNode,
                      autofillHints: [AutofillHints.username],
                      keyboardAppearance: Brightness.light,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(hintText: widget.hintText),
                      keyboardType: TextInputType.text,
                      validator: widget.validator,
                    );
                  case FieldType.multipleChoice:
                    return FormBuilderField<List<dynamic>>(
                      validator: (widget.isRequired)
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).empty_field_error;
                              }
                              return null;
                            }
                          : null,
                      name: widget.name,
                      onChanged: widget.onChanged,
                      initialValue: widget.initialValue ?? [],
                      builder: (FormFieldState<dynamic> field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MultiSelectFormField(
                              answers: widget.itemsMultiChoice!,
                              initValue: widget.initialValue ?? [],
                              backgroundItemColor: widget.backgroundItemsMultiChoiceColor,
                              onSaved: (List<String> value) {
                                field.didChange(value);
                                field.validate();
                              },
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(left: 16, top: 8),
                                child: Text(
                                  S.of(context).empty_field_error,
                                  style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.red),
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  case FieldType.select:
                    return FormBuilderField<String>(
                      validator: (widget.isRequired)
                          ? (value) {
                              if (value == null || value == '') {
                                return S.of(context).empty_field_error;
                              }
                              return null;
                            }
                          : null,
                      name: widget.name,
                      onChanged: widget.onChanged,
                      initialValue: widget.initialValue ?? '',
                      builder: (FormFieldState<dynamic> field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectFormField(
                              items: widget.itemsMultiChoice!,
                              initValue: widget.initialValue ?? '',
                              onSaved: (String value) {
                                field.didChange(value);
                                field.validate();
                              },
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(left: 16, top: 8),
                                child: Text(
                                  S.of(context).empty_field_error,
                                  style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Colors.red),
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  case FieldType.numberInput:
                    return FormBuilderField(
                      name: widget.name,
                      onChanged: widget.onChanged,
                      initialValue: widget.initialValue,
                      builder: (FormFieldState<dynamic> field) {
                        return NumberInputWithIncrementDecrement(
                          controller: TextEditingController(),
                          initialValue: widget.initialValue,
                          widgetContainerDecoration: BoxDecoration(
                            border: Border.all(color: AppColor.borderColor),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          incIcon: Icons.keyboard_arrow_up,
                          incIconDecoration: BoxDecoration(
                            color: const Color(0xFfEFEFEF),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.sp)),
                          ),
                          decIcon: Icons.keyboard_arrow_down,
                          incIconColor: AppColor.borderColor,
                          decIconColor: AppColor.borderColor,
                          decIconDecoration: BoxDecoration(
                            color: const Color(0xFfEFEFEF),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.sp)),
                          ),
                          numberFieldDecoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.transparent, width: 0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.transparent, width: 0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            filled: false,
                          ),
                          onDecrement: (num value) {
                            field.didChange(value);
                          },
                          onIncrement: (num value) {
                            field.didChange(value);
                          },
                          onChanged: (num value) {
                            field.didChange(value);
                          },
                        );
                      },
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
