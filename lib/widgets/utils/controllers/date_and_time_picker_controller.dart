// ignore: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateAndTimePickerController {
  String title;
  final String errorMessage;
  final VoidCallback _updateFunc;
  final List<bool Function(String)> validationFunc;

  bool isValid = true;
  DateTime? selectedDate;
  TextEditingController? textEditingController;

  String text;

  DateAndTimePickerController(
    this.title,
    this.validationFunc,
    this.errorMessage,
    this._updateFunc, {
    this.text = '',
    this.textEditingController,
  });

  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');

  dispose() {
    textEditingController?.dispose();
  }

  changeDate(DateTime? dateTime, TimeOfDay? timeOfDay) {
    dateTime = DateTime(
      dateTime?.year ?? DateTime.now().year,
      dateTime?.month ?? DateTime.now().month,
      dateTime?.day ?? DateTime.now().day,
      timeOfDay?.hour ?? TimeOfDay.now().hour,
      timeOfDay?.minute ?? TimeOfDay.now().minute,
    );
    selectedDate = dateTime;
    text = formatter.format(selectedDate!.toLocal());
    textEditingController = TextEditingController(text: text);
    textEditingController?.text = text;
    isValid = true;
    _updateFunc();

    debugPrint('tex: $text | editing:  $selectedDate');
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

  DateAndTimePickerController copyWith({
    String? title,
    List<bool Function(String)>? validationFunc,
    String? errorMessage,
    bool? obscureText,
    String? text,
  }) {
    return DateAndTimePickerController(
      title ?? this.title,
      validationFunc ?? this.validationFunc,
      errorMessage ?? this.errorMessage,
      _updateFunc,
      text: text ?? this.text,
      textEditingController: TextEditingController(text: this.text),
    );
  }

  static DateAndTimePickerController emptyController() {
    return DateAndTimePickerController(
      '',
      [],
      '',
      () {},
      textEditingController: TextEditingController(),
    );
  }
}
