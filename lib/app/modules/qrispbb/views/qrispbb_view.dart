import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/qrispbb/controllers/qrispbb_controller.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class QrispbbView extends GetView<QrispbbController> {
  const QrispbbView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    return Scaffold(
      appBar:
          CustomAppBar(title: "QRIS Payment PBB", leading: true, isLogin: true),
      body: GetBuilder<QrispbbController>(
        init: QrispbbController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: Dialog(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // The loading indicator
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      // Some text
                      Text('Loading...'),
                      Text(
                        "${controller.ket_loading}",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Container(
                                      height: 65.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 0,
                                            color: Color(0xFFE0E3E7),
                                            offset: Offset(0, 1),
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 0, 0),
                                                child: Text(
                                                  '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(controller.totalpajak.toString()))}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: textColor,
                                                      fontSize: 13.sp),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.timer_outlined,
                                                  size: 16.sp,
                                                  color: MainColor,
                                                ),
                                                Obx(
                                                  () {
                                                    final hours = strDigits(
                                                        controller.myDuration
                                                            .value.inHours
                                                            .remainder(1));
                                                    final minutes = strDigits(
                                                        controller.myDuration
                                                            .value.inMinutes
                                                            .remainder(60));
                                                    final seconds = strDigits(
                                                        controller.myDuration
                                                            .value.inSeconds
                                                            .remainder(60));
                                                    return Text(
                                                      ' $hours:$minutes:$seconds',
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 13.5.sp,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 15.h),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Container(
                                      height: 65.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 0,
                                            color: Color(0xFFE0E3E7),
                                            offset: Offset(0, 1),
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 8, 8, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 4, 0, 0),
                                                child: Text(
                                                  'Metode Pembayaran',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: textColor,
                                                      fontSize: 12.sp),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/images/qris.png",
                                                    width: 62.w,
                                                    fit: BoxFit.cover),
                                                SizedBox(width: 4),
                                                Image.asset(
                                                  "assets/images/bpd.png",
                                                  width: 70.w,
                                                  fit: BoxFit.fill,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 15.h),
                                Screenshot(
                                  controller: controller.controller,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/images/qris.png",
                                              width: 100.w, fit: BoxFit.cover),
                                          QrImageView(
                                            data: controller.barcode_qris,
                                            version: QrVersions.auto,
                                            size: 230.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 90),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // easyThrottle(
                                          //   handler: () async {
                                          //     final image = await controller
                                          //         .controller
                                          //         .capture();
                                          //     if (image == null) return;
                                          //     controller.saveAndShare(image);
                                          //   },
                                          // );
                                        },
                                        child: Container(
                                          width: 60.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.cyan,
                                                Color.fromARGB(
                                                    255, 89, 109, 225)
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 5,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Icon(Icons.share_sharp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // easyThrottle(
                                          //   handler: () async {
                                          //     final image = await controller
                                          //         .controller
                                          //         .capture();
                                          //     if (image == null) return;
                                          //     await controller.saveImage(image);
                                          //   },
                                          // );
                                        },
                                        child: Container(
                                          width: 60.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.cyan,
                                                Color.fromARGB(
                                                    255, 89, 109, 225)
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 5,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Icon(Icons.download,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 230.w,
                                        child: Buttons.gradientButton(
                                            handler: () {
                                              easyThrottle(
                                                handler: () {
                                                  controller.CheckPembayaran();
                                                },
                                              );
                                            },
                                            widget:
                                                Text("Cek Status Pembayaran"),
                                            gradient: gradientColor),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 20),
                                        child: Text(
                                          "Petunjuk Pembayaran",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                      _PakaiDeviceYangSama(),
                                      _PakaiBedaDevice(),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _PakaiDeviceYangSama() {
    return Card(
      child: ExpansionTile(
        title: Text(
          "Dengan Smartphone yang sama",
          style: TextStyle(fontSize: 11.5.sp),
        ),
        children: <Widget>[
          ListTile(
              title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. \n2. \n3.\n \n4.\n \n5. ",
                    style: TextStyle(
                        fontSize: 11.sp, height: 1.7, letterSpacing: 0.0),
                  ),
                  SizedBox(width: 15.w),
                  Container(
                    width: 270.w,
                    child: Text(
                      "Download QRIS dengan klik Icon Download. \nBuka Aplikasi/Mobile Banking anda.\nMasukkan ID User dan password. \nPilih Menu QRIS/Pembayaran Dengan QRIS. \nPilih metode QRIS melalui Gallery Photo Smartphone \nDetail Pembayaran akan tampil \nKlik Bayar dan Masukkan PIN Transaksi. ",
                      style: TextStyle(
                          fontSize: 11.sp, height: 1.7, letterSpacing: 0.0),
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _PakaiBedaDevice() {
    return Card(
      child: ExpansionTile(
        title: Text(
          "Dengan Beda Smartphone",
          style: TextStyle(fontSize: 11.5.sp),
        ),
        children: <Widget>[
          ListTile(
              title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. \n2. \n3.\n \n4.",
                    style: TextStyle(
                        fontSize: 11.sp, height: 1.7, letterSpacing: 0.0),
                  ),
                  SizedBox(width: 15.w),
                  Container(
                    width: 270.w,
                    child: Text(
                      "Buka Aplikasi/Mobile Banking anda.\nMasukkan ID User dan password. \nPilih Menu QRIS/Pembayaran Dengan QRIS. \nScan QRIS dan Detail Pembayaran akan tampil \nKlik Bayar dan Masukkan PIN Transaksi. ",
                      style: TextStyle(
                          fontSize: 11.sp, height: 1.7, letterSpacing: 0.0),
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
