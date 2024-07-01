import 'package:flutter/services.dart';

class InputFormatters {
  static List<TextInputFormatter> alphabeticOnly() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
    ];
  }

  static List<TextInputFormatter> numericOnly() {
    return [
      FilteringTextInputFormatter.digitsOnly,
    ];
  }

  static List<TextInputFormatter> alphanumericOnly() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
    ];
  }

  static List<TextInputFormatter> spaceRestricted() {
    return [
      FilteringTextInputFormatter.deny(RegExp(r'\s{1,}')),
      TextInputFormatter.withFunction(
            (oldValue, newValue) {
          // Allow only one space character
          if (newValue.text.contains(' ')) {
            return oldValue.copyWith(
              text: oldValue.text.trimRight(),
              selection: TextSelection.collapsed(offset: oldValue.text.length),
            );
          }
          return newValue;
        },
      ),
    ];
  }

// Add more input formatters as needed
}
