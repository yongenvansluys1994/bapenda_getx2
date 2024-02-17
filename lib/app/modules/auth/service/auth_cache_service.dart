import 'package:bapenda_getx2/app/modules/auth/dto/user_model.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:get_storage/get_storage.dart';

mixin AuthCacheService {
  Future<bool> saveUserData(User userData) async {
    final box = GetStorage();
    await box.write(STORAGE_LOGIN_USER_DATA, userData);
    return true;
  }

  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.remove(STORAGE_LOGIN_DATA);
    await box.write(STORAGE_LOGIN_DATA, token);
    return true;
  }

  Future<bool> saveRefreshToken(String? token) async {
    final box = GetStorage();
    await box.remove(STORAGE_LOGIN_DATA_REFRESH);
    await box.write(STORAGE_LOGIN_DATA_REFRESH, token);
    return true;
  }

  Map<String, dynamic>? getUserData() {
    final box = GetStorage();
    return box.read(STORAGE_LOGIN_USER_DATA);
  }

  String? getRefreshToken() {
    final box = GetStorage();
    return box.read(STORAGE_LOGIN_DATA_REFRESH);
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(STORAGE_LOGIN_DATA);
  }

  String getAccessToken() {
    final box = GetStorage();
    return box.read(STORAGE_LOGIN_DATA);
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(STORAGE_LOGIN_DATA);
  }

  Future<void> removeUserdata() async {
    final box = GetStorage();
    await box.remove(STORAGE_LOGIN_USER_DATA);
  }
}
