import 'package:get/get.dart';

import '../controllers/lengkapi_data_controller.dart';

class LengkapiDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LengkapiDataController>(() => LengkapiDataController(),
        fenix: true);
  }
}
