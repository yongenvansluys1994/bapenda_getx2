import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/va_page_controller.dart';

class VaPageView extends GetView<VaPageController> {
  const VaPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    return Scaffold(
      appBar: CustomAppBar(
        title: "Virtual Account Payments",
        leading: true,
        isLogin: true,
      ),
      body: GetBuilder<VaPageController>(
        init: VaPageController(Get.find<Api>()),
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
                                                      fontSize: 15.sp),
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
                                                            .remainder(24));
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
                                                  child: Texts.body2(
                                                      "Metode Pembayaran (VA)",
                                                      color: MainColor,
                                                      isBold: true)),
                                            ),
                                            Image.asset(
                                              "assets/images/bpd.png",
                                              width: 70.w,
                                              fit: BoxFit.fill,
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
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
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 0, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.account_balance,
                                                          color: MainColor,
                                                          size: 17.sp,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Texts.caption(
                                                                " Kode Bank",
                                                                color:
                                                                    MainColor),
                                                            Texts.captionSm(
                                                                " (Jika Transfer dari Bank lain)",
                                                                color:
                                                                    MainColor),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 4, 0, 0),
                                                    child: Texts.caption("124",
                                                        color: MainColor,
                                                        isBold: true),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
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
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 0, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .credit_card_outlined,
                                                          color: MainColor,
                                                          size: 17.sp,
                                                        ),
                                                        Texts.caption(
                                                          " No. Virtual Account",
                                                          color: MainColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 4, 0, 0),
                                                    child: Texts.caption(
                                                        '${controller.virtual_account.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")}',
                                                        color: MainColor,
                                                        isBold: true),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Card(
                                              child: InkWell(
                                                onTap: () {
                                                  Clipboard.setData(ClipboardData(
                                                          text: controller
                                                              .virtual_account))
                                                      .then((_) {
                                                    RawSnackbar_top(
                                                        message:
                                                            "No. Virtual Account telah di Salin",
                                                        kategori: "success",
                                                        duration: 2);
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.copy,
                                                    color: MainColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 20.h),
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
                                        width: 200.w,
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
                                SizedBox(height: 55.h),
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
                                          padding: EdgeInsets.only(
                                              top: 10, left: 20),
                                          child: Texts.body2(
                                              "Petunjuk Pembayaran",
                                              isBold: true)),
                                      _DGBankaltimtara(),
                                      _ATMBankaltim(),
                                      _BankLain(),
                                      _MobileBankLain()
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

  Widget _DGBankaltimtara() {
    return Card(
      child: ExpansionTile(
        title: Texts.caption("DG Bankaltimtara"),
        children: <Widget>[
          ListTile(
              title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. \n2. \n3.\n \n4.\n5. \n \n\n6.",
                    style: TextStyle(
                        fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
                  ),
                  SizedBox(width: 1.5.w),
                  Container(
                    width: 280.w,
                    child: Text(
                      "Buka Aplikasi DG Bankaltimtara di Smartphone.\nMasukkan ID User dan password. \nKlik Menu Pembayaran > Pilih Virtual Account. \nMasukkan No. Virtual Account dari Aplikasi Invoice Aplikasi Bapenda Etam > Klik Lanjut \nPastikan Angka Nominal & Nama Pembayaran sesuai yang terdapat pada Aplikasi Bapenda Etam > Lanjutkan. \nMasukkan PIN transaksi Anda lalu selesaikan Pembayaran. Periksa Aplikasi Bapenda Etam untuk melihat Status bayar menjadi Lunas.",
                      style: TextStyle(
                          fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
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

  Widget _ATMBankaltim() {
    return Card(
      child: ExpansionTile(
        title: Texts.caption("ATM Bankaltimtara"),
        children: <Widget>[
          ListTile(
              title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. \n2. \n3.\n \n4.\n \n5. \n6. \n7. ",
                    style: TextStyle(
                        fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
                  ),
                  SizedBox(width: 1.5.w),
                  Container(
                    width: 280.w,
                    child: Text(
                      "Masukkan kartu ATM Anda ke dalam mesin dan masukkan PIN Anda. \nPilih menu Pembayaran atau Bayar. \nPilih Virtual Account atau VA. \nMasukkan No. Virtual Account Bankaltimtara. Pastikan nominal yang muncul di layar sudah sesuai dengan nominal di invoice. \nPilih OK atau YES. \nSelesai. Periksa Aplikasi Bapenda Etam untuk melihat Status bayar menjadi Lunas.",
                      style: TextStyle(
                          fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
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

  Widget _BankLain() {
    return Card(
      child: ExpansionTile(
        title: Texts.caption("Dari ATM Bank Lain/Beda Bank"),
        children: <Widget>[
          ListTile(
              title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. \n\n2. \n \n3.\n \n4.\n \n5.\n6.",
                    style: TextStyle(
                        fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
                  ),
                  SizedBox(width: 1.5.w),
                  Container(
                    width: 280.w,
                    child: Text(
                      "Masukkan kartu ATM Anda ke dalam mesin dan masukkan PIN Anda. \nPilih menu Transaksi Lainnya > Transfer > Antar Bank Online. \nMasukkan Kode Bank (124) dan Nomor Virtual Account tujuan. \nPastikan nominal yang muncul di layar sudah sesuai dengan nominal di invoice. \nPilih OK atau YES. \nSelesai. Periksa Aplikasi Bapenda Etam untuk melihat Status bayar menjadi Lunas.",
                      style: TextStyle(
                          fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
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

  Widget _MobileBankLain() {
    return Card(
      child: ExpansionTile(
        title: Texts.caption("Dari Aplikasi Mobile Bank Lain/Beda Bank"),
        children: <Widget>[
          ListTile(
              title: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. \n\n2. \n3. \n4.\n\n\n5. \n \n\n6.",
                    style: TextStyle(
                        fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
                  ),
                  SizedBox(width: 1.5.w),
                  Container(
                    width: 280.w,
                    child: Text(
                      "Buka Aplikasi Mobile Bank Pilihan Anda di Smartphone.\nMasukkan ID User dan password. \nKlik Menu Transfer. \nPilih Bank Tujuan & Masukkan Kode Bank (124) dan Nomor Virtual Account dari Aplikasi Bapenda Etam di Nomor Rekening Tujuan. \nPastikan Angka Nominal & Nama Pembayaran sesuai yang terdapat pada Aplikasi Bapenda Etam & Lanjutkan. \nMasukkan PIN transaksi Anda lalu selesaikan Pembayaran. Periksa Aplikasi Bapenda Etam untuk melihat Status bayar menjadi Lunas.",
                      style: TextStyle(
                          fontSize: 12.5.sp, height: 1.7, letterSpacing: 0.0),
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
