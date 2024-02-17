// ignore: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerController {
  String title;
  final String errorMessage;
  final VoidCallback _updateFunc;
  final List<bool Function(String)> validationFunc;

  bool isValid = true;
  DateTimeRange? selectedDateTime;
  TextEditingController? startEditingController;
  TextEditingController? endEditingController;

  String start;
  String end;

  DateTime? startTime;
  DateTime? endTime;

  DateRangePickerController(
    this.title,
    this.validationFunc,
    this.errorMessage,
    this._updateFunc, {
    this.startEditingController,
    this.endEditingController,
    this.start = '',
    this.end = '',
  });

  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  dispose() {
    startEditingController = TextEditingController();
    startEditingController?.dispose();
    endEditingController = TextEditingController();
    endEditingController?.dispose();
  }

  changeDate(DateTime dateTime, {DateTimeRange? dateTimeRange}) {
    selectedDateTime = dateTimeRange;

    startTime = selectedDateTime?.start.toLocal();
    endTime = selectedDateTime?.end.toLocal();

    start = formatter.format(selectedDateTime!.start.toLocal());
    end = formatter.format(selectedDateTime!.end.toLocal());
    startEditingController = TextEditingController(text: start);
    startEditingController?.text = start;
    endEditingController = TextEditingController(text: end);
    endEditingController?.text = end;
    isValid = true;
    _updateFunc();

    debugPrint('DateRangePickerController.changeDate() => $start | $end');
    return;
  }

  bool checkValid() {
    debugPrint(
        '${startEditingController?.text} | ${endEditingController?.text} | $start | $end');
    isValid = startEditingController?.text != null &&
        endEditingController?.text != null;
    if (startEditingController?.text != null &&
        startEditingController!.text.isNotEmpty &&
        endEditingController?.text != null &&
        endEditingController!.text.isNotEmpty) {
      isValid = true;
    } else {
      isValid = false;
    }

    debugPrint('DateRangePickerController.checkValid() => $isValid');
    return isValid;
  }

  DateRangePickerController copyWith({
    String? title,
    List<bool Function(String)>? validationFunc,
    String? errorMessage,
    bool? obscureText,
    String? text,
    String? start,
    String? end,
  }) {
    return DateRangePickerController(
      title ?? this.title,
      validationFunc ?? this.validationFunc,
      errorMessage ?? this.errorMessage,
      _updateFunc,
      start: start ?? this.start,
      end: end ?? this.end,
      startEditingController: TextEditingController(text: this.start),
      endEditingController: TextEditingController(text: this.end),
    );
  }

  static DateRangePickerController emptyController() {
    return DateRangePickerController(
      '',
      [],
      '',
      () {},
      startEditingController: TextEditingController(),
      endEditingController: TextEditingController(),
    );
  }
}
