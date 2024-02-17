// ignore_for_file: depend_on_referenced_packages, unused_import, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:bapenda_getx2/app/modules/auth/dto/auth_via_keycloak_dto.dart';
import 'package:bapenda_getx2/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:http/http.dart' as http;

class AuthViaKeycloakService with AuthCacheService {
  Future<AuthViaKeycloakDto> login(String username, String password) async {
    try {
      Map<String, String> bodyData = {
        'client_id': KEYCLOAK_CLIENT_ID,
        'username': username,
        'password': password,
        'grant_type': GRANT_TYPE_PASSWORD
      };

      return await _getToken(bodyData);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<AuthViaKeycloakDto> refreshToken() async {
    try {
      String _refreshToken = getRefreshToken()!;

      Map<String, String> bodyData = {
        'client_id': KEYCLOAK_CLIENT_ID,
        'grant_type': GRANT_TYPE_REFRESH_TOKEN,
        'refresh_token': _refreshToken,
      };

      return await _getToken(bodyData);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> logout() async {}

  Future<AuthViaKeycloakDto> _getToken(Map<String, String> data) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cache-Control': 'no-cache'
    };

    http.Response response = await http.post(
      Uri.parse(KEYCLOAK_HOST_URL),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      final dynamic token = json.decode(response.body);

      AuthViaKeycloakDto _authViaKeycloakDto =
          AuthViaKeycloakDto.fromJson(token);

      return _authViaKeycloakDto;
    } else if (response.statusCode == 401) {
      return throw ("Incorrect ID Number or Password");
    } else if (response.statusCode == 400) {
      return throw ("Something wrong, please check Form");
    } else {
      throw ("Server error");
    }
  }
}
