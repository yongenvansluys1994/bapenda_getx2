import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:get/get.dart';

import '../controllers/qris_page_controller.dart';

class QrisPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrisPageController>(
      () => QrisPageController(Get.find<Api>()),
    );
  }
}
