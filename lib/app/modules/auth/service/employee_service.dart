// ignore_for_file: depend_on_referenced_packages

import 'package:bapenda_getx2/app/modules/auth/dto/soe_model.dart';
import 'package:bapenda_getx2/app/modules/auth/dto/user_model.dart';
import 'package:bapenda_getx2/core/services/graphql_client_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeService extends GraphQLClientService {
  Future<Soe> getEmployee(String personalNumber) async {
    String url =
        "https://api.gmf-aeroasia.co.id/th/soe/v1/employee/$personalNumber";
    Map<String, String> headers = {'x-api-key': '343C-ED0B-4137-B27E'};
    final response = await http.get(Uri.parse(url), headers: headers);
    final jsonResponse = jsonDecode(response.body);
    return Soe.fromJson(jsonResponse['body']);
  }

  Future<User> getUser(String personalNumber) async {
    String url =
        "https://yongen-bisa.com/bapenda_app/api_ver2/login/check.php?nik=$personalNumber";

    final response = await http.get(Uri.parse(url));
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse['data']);
    return User.fromJson(jsonResponse['data']);
  }
}
