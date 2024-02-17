import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:get/get.dart';

class ObjekkuController extends GetxController {
  late AuthModel authModel;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
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
