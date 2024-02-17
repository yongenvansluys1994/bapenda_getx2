import 'package:get/get.dart';

import '../controllers/ebilling_controller.dart';

class EbillingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EbillingController>(
      () => EbillingController(),
    );
  }
}
