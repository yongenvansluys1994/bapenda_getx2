import 'package:get/get.dart';

import '../controllers/register_baru_controller.dart';

class RegisterBaruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterBaruController>(
      () => RegisterBaruController(),
    );
  }
}
