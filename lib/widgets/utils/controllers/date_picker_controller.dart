// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DatePickerController {
  String title;
  final String errorMessage;
  final VoidCallback _updateFunc;
  final List<bool Function(String)> validationFunc;

  bool isValid = true;
  DateTime? selectedDate;
  TextEditingController? textEditingController;

  String text;

  DatePickerController(
    this.title,
    this.validationFunc,
    this.errorMessage,
    this._updateFunc, {
    this.text = '',
    this.textEditingController,
  });

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  dispose() {
    textEditingController = TextEditingController();
    textEditingController?.dispose();
  }

  changeDate(DateTime dateTime) {
    selectedDate = dateTime;
    text = formatter.format(selectedDate!.toLocal());
    textEditingController = TextEditingController(text: text);
    textEditingController?.text = text;
    isValid = true;
    _updateFunc();

    debugPrint(text);
  }

  bool checkValid() {
    debugPrint('${textEditingController?.text} | $text');
    isValid = textEditingController?.text != null;
    if (textEditingController?.text != null &&
        textEditingController!.text.isNotEmpty) {
      isValid = true;
    } else {
      isValid = false;
    }

    debugPrint('isValid : $isValid');
    return isValid;
  }

  DatePickerController copyWith({
    String? title,
    List<bool Function(String)>? validationFunc,
    String? errorMessage,
    bool? obscureText,
    String? text,
  }) {
    return DatePickerController(
      title ?? this.title,
      validationFunc ?? this.validationFunc,
      errorMessage ?? this.errorMessage,
      _updateFunc,
      text: text ?? this.text,
      textEditingController: TextEditingController(text: this.text),
    );
  }

  static DatePickerController emptyController() {
    return DatePickerController(
      '',
      [],
      '',
      () {},
      textEditingController: TextEditingController(),
    );
  }
}
