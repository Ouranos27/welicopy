import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormatCurrencyText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue.copyWith(text: '');

    if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###");
      final number = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(number);
      return TextEditingValue(
        text: newString.replaceAll(',', ' '),
        selection: TextSelection.collapsed(offset: newString.length - selectionIndexFromTheRight),
      );
    }

    return newValue;
  }
}
