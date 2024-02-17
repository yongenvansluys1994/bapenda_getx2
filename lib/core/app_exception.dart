// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:equatable/equatable.dart';
import 'package:bapenda_getx2/core/services/log_service.dart';

class AppException extends Equatable implements Exception {
  String _message = "";
  String _instance = "AppException";
  dynamic data;
  late LogService logService;

  String get message => _message;
  String get instance => _instance;

  AppException(String message, String instance, dynamic exceptiondata) {
    _message = message;
    _instance = instance;
    logService = LogService(instance);
    data = exceptiondata;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      "message": _message,
      "instance": _instance,
      "data": data,
    };
    return result;
  }

  String toJsonString() {
    return toJson().toString();
  }

  @override
  String toString() {
    return '[$_instance]:$_message';
  }

  @override
  List<Object> get props => [_message, _instance, data];
}
