// ignore_for_file: depend_on_referenced_packages, unused_import, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:bapenda_getx2/app/modules/auth/dto/auth_via_keycloak_dto.dart';
import 'package:bapenda_getx2/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthViaDBService with AuthCacheService {
  Future login(String username, String password) async {
    try {
      Map<String, String> bodyData = {
        'nik': username,
        'password': password,
      };

      return await _loginProses(bodyData);
    } catch (err) {
      RawSnackbar_top(message: "${err}", kategori: "error", duration: 2);
      EasyLoading.dismiss();
    }
  }

  Future _loginProses(Map<String, String> data) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cache-Control': 'no-cache'
    };

    http.Response response = await http
        .post(
          Uri.parse(YONGENBISA_HOST_URL), //gmf pakai KEYCLOAK_HOST_URL
          headers: headers,
          body: data,
        )
        .timeout(Duration(seconds: 10));
    final dynamic datauser = json.decode(response.body);

    print("asdasda:${datauser}");
    if (response.statusCode == 200 && datauser['success'] == true) {
      //AuthViaKeycloakDto _authViaKeycloakDto =
      //AuthViaKeycloakDto.fromJson(token);

      return datauser;
    } else if (datauser['success'] == false) {
      return throw ("Incorrect ID Number or Password");
    } else if (response.statusCode == 400) {
      return throw ("Something wrong, please check Form");
    } else {
      throw ("Server error");
    }
  }
}
