import 'package:flutter/services.dart';

class TextFormatter {
  static List<TextInputFormatter> get ktp => [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(16),
      ];

  static List<TextInputFormatter> get npwp => [
        NpwpFormatter(),
        LengthLimitingTextInputFormatter(20),
      ];
}

class NpwpFormatter extends TextInputFormatter {
  TextEditingValue _addSeparator(TextEditingValue oldValue,
      TextEditingValue newValue, int lengChar, String separator) {
    if (newValue.text.length == lengChar && lengChar > 0) {
      if (oldValue.text.contains(separator) &&
          newValue.text.length < oldValue.text.length) {
        return newValue.copyWith(
          text: newValue.text.substring(0, newValue.text.length - 1),
          selection: TextSelection.collapsed(
            offset: newValue.text.substring(0, newValue.text.length - 1).length,
          ),
        );
      }
      return newValue.copyWith(
        text: newValue.text + separator,
        selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
      );
    }
    return newValue;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    newValue = _addSeparator(oldValue, newValue, 2, ".");
    newValue = _addSeparator(oldValue, newValue, 6, ".");
    newValue = _addSeparator(oldValue, newValue, 10, ".");
    newValue = _addSeparator(oldValue, newValue, 12, "-");
    newValue = _addSeparator(oldValue, newValue, 16, ".");
    return newValue;
  }
}
