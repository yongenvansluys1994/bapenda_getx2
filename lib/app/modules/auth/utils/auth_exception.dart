// ignore_for_file: annotate_overrides, overridden_fields, must_be_immutable

import 'dart:convert';

import 'package:bapenda_getx2/core/app_exception.dart';

class AuthException extends AppException {
  String message;
  dynamic data;

  AuthException(this.message, {this.data})
      : super(message, 'AuthException', data);

  @override
  String toString() {
    if (data != null && data.length != 0) {
      var msg = jsonDecode(data);
      return "Auth Exceptions: ${msg["details"]}";
    }
    return "Auth Exception: ${super.toJson()}";
  }
}
