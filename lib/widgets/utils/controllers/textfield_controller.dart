import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../debouncer.dart';

class TextFieldController {
  final bool obscureText;
  final String title;
  final String errorMessage;
  final VoidCallback _updateFunc;
  final Debouncer? _debouncer;
  final List<bool Function(String)> validationFunc;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? textEditingController;

  bool visible = false;
  bool isValid = true;
  String text;

  TextFieldController(this.title, this.validationFunc, this.errorMessage,
      this._updateFunc, this._debouncer,
      {this.obscureText = false,
      this.text = "",
      this.inputFormatter,
      this.textEditingController});

  onChange(String value) {
    text = value;
    _debouncer?.run(() {
      if (value.isEmpty ||
          validationFunc.isEmpty ||
          validationFunc.any((e) => e(value))) {
        isValid = true;

        if (inputFormatter != null) {
          text = value.replaceAll('.', '');
        } else {
          text = value;
        }
      } else {
        isValid = false;
        text = "";
      }
      _updateFunc();
    });
  }

  toogleVisible() {
    visible = !visible;
    _updateFunc();
  }

  dispose() {
    textEditingController!.clear();
  }

  bool checkValid() {
    isValid = text.isNotEmpty;
    return isValid;
  }

  reset({val = ""}) {
    isValid = true;
    text = val;
    _updateFunc();
  }

  TextFieldController copyWith({
    String? title,
    List<bool Function(String)>? validationFunc,
    String? errorMessage,
    bool? obscureText,
    String? text,
  }) {
    return TextFieldController(
      title ?? this.title,
      validationFunc ?? this.validationFunc,
      errorMessage ?? this.errorMessage,
      _updateFunc,
      _debouncer,
      obscureText: obscureText ?? this.obscureText,
      text: text ?? this.text,
    );
  }

  static TextFieldController emptyController() {
    return TextFieldController("", [], "", () {}, null);
  }
}
