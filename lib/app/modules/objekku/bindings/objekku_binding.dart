import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/controllers/lapor_pajak_controller.dart';
import 'package:get/get.dart';


class ObjekkuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporPajakController>(
      () => LaporPajakController(Get.find<Api>()),
    );
  }
}
