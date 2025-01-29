import 'package:bapenda_getx2/app/modules/ekitiran/controllers/ekitiran_controller.dart';
import 'package:get/get.dart';

import '../controllers/ekitiran_form_controller.dart';

class EkitiranFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EkitiranFormController>(
      () => EkitiranFormController(),
    );
    Get.lazyPut<EkitiranController>(
      () => EkitiranController(),
    );
  }
}
