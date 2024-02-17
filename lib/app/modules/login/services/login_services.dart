// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:bapenda_getx2/app/core/api/api.dart';

class LoginServices {
  Api api;
  LoginServices(this.api);

  Future token_fcm(data) {
    return api.insertTokenFCM(data).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError
              ? (e as DioError).error
              : "Terjadi Kesalahan nih: $e",
        );
      },
    );
  }
}
