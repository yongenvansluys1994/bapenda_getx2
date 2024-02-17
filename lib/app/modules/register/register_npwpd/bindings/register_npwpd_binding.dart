import 'package:get/get.dart';

import '../controllers/register_npwpd_controller.dart';

class RegisterNpwpdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterNpwpdController>(
      () => RegisterNpwpdController(),
    );
  }
}
