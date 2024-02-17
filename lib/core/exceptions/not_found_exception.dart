// ignore_for_file: annotate_overrides, overridden_fields

import 'package:bapenda_getx2/core/app_exception.dart';

// ignore: must_be_immutable
class NotFoundException extends AppException {
  String message;
  dynamic data;

  NotFoundException(this.message, this.data)
      : super(message, 'NotFoundException', data);
}
