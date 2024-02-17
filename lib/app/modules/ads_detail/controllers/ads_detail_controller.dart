import 'package:bapenda_getx2/app/modules/myprofil/models/model_ads.dart';
import 'package:get/get.dart';

class AdsDetailController extends GetxController {
  late ModelAds dataArgument;
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
