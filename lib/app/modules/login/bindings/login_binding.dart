import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/login/controllers/login_controller.dart';
import 'package:bapenda_getx2/app/modules/login/services/login_services.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        LoginServices(
          Get.find<Api>(),
        ),
      ),
    );
  }
}
