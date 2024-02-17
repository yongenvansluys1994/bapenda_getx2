import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      final box = GetStorage();
      var user = box.read(STORAGE_LOGIN_USER_DATA);

      if (user == null) {
        Get.offNamed(Routes.LOGIN);
      } else {
        Get.offNamed(Routes.DASHBOARD, arguments: "autologin");
      }
    });
  }
}

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
