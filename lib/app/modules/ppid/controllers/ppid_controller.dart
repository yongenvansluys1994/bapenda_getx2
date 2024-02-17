import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/myprofil/models/model_ads.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PpidController extends GetxController {
  late AuthModel authModel;
  Api api;
  PpidController(this.api);
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelAds> datalist = <ModelAds>[].obs;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchPPID();
    update();
  }

  Future<void> fetchPPID() async {
    try {
      isLoading = true;
      update();

      final datauser = await api.getPPID(authModel.nik);

      if (datauser == null) {
        isFailed = true;
        isLoading = false;
        update();
      } else if (datauser.isEmpty) {
        isEmpty = true;
        isLoading = false;
        update();
      } else {
        isLoading = false;
        datalist.addAll(datauser);
        isEmpty = false;
        update();
      }

      isLoading = false;
      update();
    } on DioError catch (ex) {
      var errorMessage = "";
      if (ex.type == DioErrorType.connectionTimeout ||
          ex.type == DioErrorType.connectionError ||
          ex.type == DioErrorType.receiveTimeout ||
          ex.type == DioErrorType.sendTimeout) {
        errorMessage = "Limit Connection, Koneksi anda bermasalah";
      } else {
        errorMessage = "$ex";
      }
      RawSnackbar_top(message: "$errorMessage", kategori: "error", duration: 4);
      update();
    }
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
