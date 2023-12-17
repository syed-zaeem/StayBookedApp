import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Use a regular expression to allow only numeric input
    final RegExp regExp = RegExp(r'[0-9]');
    String newString = '';

    for (int i = 0; i < newValue.text.length; i++) {
      if (regExp.hasMatch(newValue.text[i])) {
        newString += newValue.text[i];
      }
    }

    return TextEditingValue(
      text: newString,
      selection:
          TextSelection.fromPosition(TextPosition(offset: newString.length)),
    );
  }
}
