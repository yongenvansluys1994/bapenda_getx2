// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerController {
  String title;
  final String errorMessage;
  final VoidCallback _updateFunc;
  final List<bool Function(String)> validationFunc;

  bool isValid = true;
  DateTime? selectedDate;
  TextEditingController? textEditingController;

  String text;

  TimePickerController(
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

  String to24hours(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, "0");
    final min = time.minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }

  changeDate(TimeOfDay timeOfDay) {
    DateTime date = DateTime.now();
    selectedDate = DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    text = selectedDate.toString();
    textEditingController =
        TextEditingController(text: DateFormat('HH:mm').format(selectedDate!));
    textEditingController?.text = DateFormat('HH:mm').format(selectedDate!);
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

  TimePickerController copyWith({
    String? title,
    List<bool Function(String)>? validationFunc,
    String? errorMessage,
    bool? obscureText,
    String? text,
  }) {
    return TimePickerController(
      title ?? this.title,
      validationFunc ?? this.validationFunc,
      errorMessage ?? this.errorMessage,
      _updateFunc,
      text: text ?? this.text,
      textEditingController: TextEditingController(text: this.text),
    );
  }

  static TimePickerController emptyController() {
    return TimePickerController(
      '',
      [],
      '',
      () {},
      textEditingController: TextEditingController(),
    );
  }
}
