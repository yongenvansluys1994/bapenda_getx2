import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/va_page_controller.dart';

class VaPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VaPageController>(
      () => VaPageController(Get.find<Api>()),
    );
  }
}
