import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/kartunpwpd/models/model_kartudata.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class KartunpwpdController extends GetxController {
  Api api;
  KartunpwpdController(this.api);
  late AuthModel authModel;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelKartuData> datalist = <ModelKartuData>[].obs;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchNPWPD();
    update();
  }

  Future<void> fetchNPWPD() async {
    try {
      isLoading = true;

      final datauser = await api.getNPWPD(authModel.nik);

      if (datauser == null) {
        isFailed = true;
      } else if (datauser.isEmpty) {
        isEmpty = true;
      } else {
        datalist.addAll(datauser);
        isEmpty = false;
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