// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';

import 'package:bapenda_getx2/app/modules/auth/dto/user_model.dart';
import 'package:bapenda_getx2/app/modules/auth/service/auth_via_db_service.dart';
import 'package:bapenda_getx2/app/modules/auth/service/employee_service.dart';
import 'package:bapenda_getx2/core/app_exception.dart';
import 'package:get/get.dart';

import 'package:bapenda_getx2/core/base_controller.dart';
import 'package:bapenda_getx2/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2/app/modules/auth/utils/auth_exception.dart';
import 'package:bapenda_getx2/app/modules/auth/utils/auth_state.dart';

class AuthController extends BaseController with AuthCacheService, StateMixin {
  final AuthViaDBService _authViaDBService = AuthViaDBService();

  final EmployeeService employeeService = EmployeeService();
  final authState2 = const AuthenticationState().obs;
  final loggedInStatus = false.obs;

  AuthenticationState get authState => authState2.value;

  @override
  void onInit() {
    super.initialize(runtimeType.toString());
    super.onInit();
    _loadLoginData();
  }

  void _loadLoginData() async {
    var _userData = getUserData();

    print(jsonEncode(_userData));
    print("123asd");
    update();
  }

  Future<void> loginViaOauth2Keycloak(
      String personalNumber, String password) async {
    try {
      await _authViaDBService.login(personalNumber, password);

      //await saveRefreshToken(keycloakService.refreshToken);

      User userInfo = await employeeService.getUser(personalNumber);

      User _userData = User(
          idUserwp: userInfo.idUserwp,
          nama: userInfo.nama,
          nik: userInfo.nik,
          noHp: userInfo.noHp,
          password: userInfo.password,
          foto: userInfo.foto,
          lastActive: userInfo.lastActive);
      //await saveToken(_userData.token);
      await saveUserData(_userData);

      loggedInStatus.value = true;

      logService.info("Logged in as ${userInfo.nama}");
    } on AuthException catch (e) {
      authState2.value = UnAuthenticated(e.toString());
      handleException(e as AppException);
    } catch (e) {
      authState2.value = UnAuthenticated(e.toString());
      logService.error(e.toString());
    }
  }
}
