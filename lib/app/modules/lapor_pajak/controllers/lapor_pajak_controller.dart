import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LaporPajakController extends GetxController {
  Api api;
  LaporPajakController(this.api);
  late AuthModel authModel;
  String? data;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelObjekku> datalist = <ModelObjekku>[].obs;

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    init();
    update();
  }

  Future init() async {
    getPajak();

    update();
  }

  Future<void> getPajak() async {
    try {
      isLoading = true;

      final datauser = await api.getData(authModel.nik);
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

  PilihPendaftaran(BuildContext context) {
    Alert(
            context: context,
            content: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    Texts.headline6("Pilih Jenis Pendaftaran", isBold: true),
                    SizedBox(height: 7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 115.w,
                          height: 115.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 2.0)
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                Get.toNamed(Routes.TAMBAH_NPWPD,
                                    arguments: authModel);
                                update();
                              },
                              splashColor: primaryColor,
                              splashFactory: InkSplash.splashFactory,
                              child: Container(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/icon-npwpd.png",
                                      width: 70.w,
                                      height: 70.h,
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Texts.captionSm("Sudah Memiliki NPWPD",
                                        isBold: true,
                                        maxLines: 2,
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 115.w,
                          height: 115.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 2.0)
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                Get.toNamed(Routes.TAMBAH_NPWPDBARU,
                                    arguments: authModel);
                                update();
                              },
                              splashColor: primaryColor,
                              splashFactory: InkSplash.splashFactory,
                              child: Container(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/icon-nonnpwpd.png",
                                      width: 70.w,
                                      height: 70.h,
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Texts.captionSm("Daftar Baru NPWPD",
                                        isBold: true,
                                        maxLines: 2,
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            style: AlertStyle(
                isButtonVisible: false, animationType: AnimationType.grow))
        .show();
  }

  PilihPajak(BuildContext context, ModelObjekku dataobjek) {
    Alert(
            context: context,
            content: Container(
              //height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    Texts.headline6("Pilih Jenis Pajak", isBold: true),
                    SizedBox(height: 7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerPilihPajak(
                            handler: () {
                              Get.toNamed(Routes.PELAPORAN_DETAIL,
                                  arguments: dataobjek,
                                  parameters: {
                                    "jenispajak": "Hotel",
                                    "nmassets": "hotel"
                                  });
                            },
                            nmPajak: "Pajak Hotel",
                            pajak: "hotel"),
                        ContainerPilihPajak(
                            handler: () {
                              Get.toNamed(Routes.PELAPORAN_DETAIL,
                                  arguments: dataobjek,
                                  parameters: {
                                    "jenispajak": "Restoran",
                                    "nmassets": "restaurant"
                                  });
                            },
                            nmPajak: "Pajak Restoran",
                            pajak: "restaurant"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerPilihPajak(
                            handler: () {
                              Get.toNamed(Routes.PELAPORAN_DETAIL_CATH,
                                  arguments: dataobjek,
                                  parameters: {
                                    "jenispajak": "Katering",
                                    "nmassets": "catering"
                                  });
                            },
                            nmPajak: "Pajak Katering",
                            pajak: "catering"),
                        ContainerPilihPajak(
                            handler: () {
                              Get.toNamed(Routes.PELAPORAN_DETAIL,
                                  arguments: dataobjek,
                                  parameters: {
                                    "jenispajak": "Parkir",
                                    "nmassets": "parkir"
                                  });
                            },
                            nmPajak: "Pajak Parkir",
                            pajak: "parkir"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerPilihPajak(
                            handler: () {
                              Get.toNamed(Routes.PELAPORAN_DETAIL,
                                  arguments: dataobjek,
                                  parameters: {
                                    "jenispajak": "Hiburan",
                                    "nmassets": "hiburan"
                                  });
                            },
                            nmPajak: "Pajak Hiburan",
                            pajak: "hiburan"),
                        ContainerPilihPajak(
                            handler: () {
                              Get.toNamed(Routes.PELAPORAN_DETAIL_PPJ,
                                  arguments: dataobjek,
                                  parameters: {
                                    "jenispajak": "PPJ",
                                    "nmassets": "ppj"
                                  });
                            },
                            nmPajak: "Pajak Pen.Jalan",
                            pajak: "ppj"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            style: AlertStyle(
                isButtonVisible: false, animationType: AnimationType.grow))
        .show();
  }

  static Widget ContainerPilihPajak(
      {required Null Function() handler,
      required String nmPajak,
      required String pajak}) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)
        ],
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: handler,
          splashColor: primaryColor,
          splashFactory: InkSplash.splashFactory,
          child: Container(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF39D2C0),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/icon/${pajak}.png',
                          width: 90.w,
                          height: 90.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Texts.captionSm(
                  '${nmPajak}',
                  isBold: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
