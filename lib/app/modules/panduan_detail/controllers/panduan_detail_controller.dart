import 'package:bapenda_getx2/app/modules/panduan/models/model_panduan.dart';
import 'package:get/get.dart';

class PanduanDetailController extends GetxController {
  late PanduanModel dataArgument;

  @override
  void onInit() {
    super.onInit();
    dataArgument = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
