import 'dart:developer';
import 'package:bapenda_getx2/utils/app_const.dart';

class LogService {
  String logName;

  LogService(this.logName);

  void debug(dynamic message) {
    if (APP_MODE == "dev") {
      log(
        message.toString(),
        time: DateTime.now(),
        name: logName,
        level: 0,
      );
    }
  }

  void info(String message) {
    log(
      message,
      time: DateTime.now(),
      name: logName,
      level: 1,
    );
  }

  void warning(String message) {
    log(
      message,
      time: DateTime.now(),
      name: logName,
      level: 2,
    );
  }

  void error(String message) {
    log(
      message,
      time: DateTime.now(),
      name: logName,
      level: 3,
    );
  }
}
