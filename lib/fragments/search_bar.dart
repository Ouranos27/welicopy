import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sizer/sizer.dart';

class SearchBarWeli extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final double? width;
  final String name;

  SearchBarWeli({
    required this.hintText,
    required this.onChanged,
    required this.name,
    this.validator,
    double? width,
  }) : width = width ?? 90.w;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FormBuilderTextField(
        onChanged: onChanged,
        name: name,
        style: const TextStyle(fontSize: 15, color: Color(0xFF555555)),
        validator: validator,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: const Icon(Icons.search, color: Colors.black),
            fillColor: const Color(0xFFECECEC),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF707070), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF707070), width: 1),
            ),
            hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            hintText: hintText),
      ),
    );
  }
}
