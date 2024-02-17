import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/myprofil_controller.dart';

class MyprofilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyprofilController>(
      () => MyprofilController(Get.find<Api>()),
    );
  }
}
