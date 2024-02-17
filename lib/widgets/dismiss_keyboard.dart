import 'package:flutter/material.dart';

dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
