import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/divider.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/topline_bottomsheet.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';

import '../controllers/ebilling_controller.dart';

class EbillingView extends GetView<EbillingController> {
  const EbillingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime originalDate = controller.dataArgument.batasBayar;
    return Scaffold(
      appBar: CustomAppBar(
        title: "E-Billing",
        leading: true,
        isLogin: true,
      ),
      body: Screenshot(
        controller: controller.SScontroller,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage("assets/images/paymentbackground.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                width: 320.w,
                height: 150.h,
                child: Stack(
                  children: [
                    Positioned(
                      left: 210.w,
                      top: 2.w,
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                                  text:
                                      "${controller.dataArgument.nomorKohir}"))
                              .then((_) {
                            RawSnackbar_top(
                                message: "Kode Bayar telah di Salin",
                                kategori: "success",
                                duration: 2);
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 50.r),
                          child: Column(
                            children: [
                              Container(
                                width: 115.h,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        "${controller.dataArgument.nomorKohir}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp),
                                      ),
                                    ),
                                    Text(
                                      "Salin Kode Bayar",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 50.r),
                            child: Lottie.asset(
                              'assets/lottie/payment_warning.json',
                              width: 60.w,
                              height: 60.h,
                            ),
                          ),
                          Text(
                            "E-BILLING ",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: MainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 290.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 78.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Texts.captionSm("Nama"),
                                      Texts.captionSm("Alamat"),
                                      Texts.captionSm("NPWPD"),
                                      Texts.captionSm("Tanggal Jatuh Tempo",
                                          maxLines: 2),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 200.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Texts.captionSm(
                                          ": ${controller.dataArgument.namaUsaha}"),
                                      Texts.captionSm(
                                          ": ${controller.dataArgument.alamatUsaha}"),
                                      Texts.captionSm(
                                          ": ${controller.dataArgument.npwpd}"),
                                      Texts.captionSm(
                                          ": ${DateFormat('dd/MM/yyyy').format(originalDate)} ",
                                          color: Colors.red,
                                          isBold: true),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.r),
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    color: appBarColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      width: 1.w,
                      color: shadowColor3,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm("Jenis Pajak Daerah",
                                    isBold: true),
                              ],
                            ),
                          ),
                          Dividers.vertical(
                            height: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm("Jumlah", isBold: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Dividers.horizontal(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm(
                                  "${controller.dataArgument.jenispajak}",
                                ),
                              ],
                            ),
                          ),
                          Dividers.vertical(
                            height: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm(
                                  "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(controller.dataArgument.pendapatan.toString()))}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Dividers.horizontal(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm(
                                  "Masa :",
                                  color: shadowColor,
                                ),
                                Texts.captionSm(
                                  "${controller.dataArgument.masaPajak2} s/d ${controller.dataArgument.masaAkhir2}",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Dividers.vertical(
                            height: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm(
                                  "Nama Usaha :",
                                  color: shadowColor,
                                ),
                                Texts.captionSm(
                                  "${controller.dataArgument.namaUsaha}",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Dividers.vertical(
                            height: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm(
                                  "Alamat :",
                                  color: shadowColor,
                                ),
                                Texts.captionSm(
                                  "${controller.dataArgument.alamatUsaha}",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Dividers.vertical(
                            height: 40,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm(
                                  "(${NumberFormat.currency(locale: 'id', symbol: '').format(int.parse(controller.dataArgument.pendapatan.toString()))} * ${double.parse(controller.dataArgument.tarifPersen).toInt()}%)",
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Dividers.vertical(
                            height: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      Dividers.horizontal(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Texts.captionSm(
                                      "Jml Ketetapan Pokok Pajak ",
                                    ),
                                    Texts.captionSm(
                                      "Denda ${controller.persenDenda}%",
                                    ),
                                  ],
                                ),
                              ),
                              Dividers.vertical(
                                height: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Texts.captionSm(
                                      "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(controller.dataArgument.pajak.toString()))}",
                                    ),
                                    Texts.captionSm(
                                      "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(controller.denda_pajak.toString()))}",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Dividers.horizontal(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                          Dividers.vertical(
                            height: 25,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.captionSm(
                                  "Total ",
                                  color: shadowColor,
                                ),
                                Texts.captionSm(
                                    "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(controller.totalPajak)}",
                                    isBold: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Texts.captionSm(
                      //       "Material Description",
                      //       color: shadowColor,
                      //     ),
                      //     Texts.captionSm(
                      //       "PACKING, PREFORMED / AXJ COLUMBUS",
                      //       textOverflow: TextOverflow.visible,
                      //       maxLines: 3,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Container(
                width: 300.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Texts.captionXs("Perhatian : "),
                    Texts.captionXs(
                        "Apabila E-billing ini tidak atau kurang dibayar lewat waktu paling lama 30 hari setelah E-billing ini dikeluarkan atau tanggal jatuh tempo dikenakan sanksi Administrasi berupa bunga sebesar 2 % per bulan.",
                        maxLines: 3)
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            easyThrottle(
                              handler: () async {
                                final image =
                                    await controller.SScontroller.capture();
                                if (image == null) return;
                                controller.saveAndShare(image);
                              },
                            );
                          },
                          child: Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.cyan,
                                  Color.fromARGB(255, 89, 109, 225)
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child:
                                  Icon(Icons.share_sharp, color: Colors.white),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            easyThrottle(
                              handler: () async {
                                final image =
                                    await controller.SScontroller.capture();
                                if (image == null) return;
                                await controller.saveImage(image);
                              },
                            );
                          },
                          child: Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.cyan,
                                  Color.fromARGB(255, 89, 109, 225)
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(Icons.download, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 35.r),
              //   child: Container(
              //     padding: EdgeInsets.all(5.sp),
              //     width: Get.width.w,
              //     decoration: BoxDecoration(
              //       color: verifiedBackgroundColor,
              //       borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(10.r),
              //         bottomRight: Radius.circular(10.r),
              //       ),
              //     ),
              //     child: Center(
              //       child: Texts.captionSm(
              //         "Verified",
              //         color: verifiedTextColor,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedOpacity(
        duration: Duration(microseconds: 0),
        opacity: 1,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 15.r),
            child: SizedBox(
              width: 400.w,
              height: 48.h,
              child: Buttons.gradientButton(
                handler: () {
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              topline_bottomsheet(),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: Transform.translate(
                                            offset: Offset(-3, -3),
                                            child: Icon(
                                              Icons.clear,
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.2.h),
                              Center(
                                child: Texts.body1("Pilih Metode Pembayaran",
                                    isBold: true),
                              ),
                              Card(
                                child: InkWell(
                                  splashColor: MainColorGreen,
                                  onTap: () {
                                    Get.toNamed(Routes.VA_PAGE, arguments: [
                                      controller.dataArgument,
                                      controller.totalPajak
                                    ]);
                                  },
                                  child: ListTile(
                                    leading: Image.asset("assets/images/va.png",
                                        width: 50.w, fit: BoxFit.cover),
                                    title: Texts.caption("Virtual Account",
                                        isBold: true, color: MainColor),
                                    visualDensity: VisualDensity(vertical: -3),
                                    subtitle: Texts.captionSm(
                                        "Kemudahan Pembayaran secara online melalui bank apa saja dengan Virtual Account",
                                        maxLines: 2),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  splashColor: MainColorGreen,
                                  onTap: () async {
                                    // getDefaultDialog().onFix(
                                    //     title: "Mohon Maaf",
                                    //     desc:
                                    //         "Fitur Pembayaran QRIS sedang dalam pengembangan",
                                    //     kategori: "error");
                                    print(controller.totalPajak);
                                    if (controller.totalPajak! > 10000000) {
                                      getDefaultDialog().onFix(
                                          title: "Mohon Maaf",
                                          desc:
                                              "Maksimal Pembayaran menggunakan QRIS adalah \nRp.10.000.000",
                                          kategori: "error");
                                    } else {
                                      Get.toNamed(Routes.QRIS_PAGE, arguments: [
                                        controller.dataArgument,
                                        controller.totalPajak
                                      ]);
                                    }
                                  },
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/images/qris.png",
                                        width: 50.w,
                                        fit: BoxFit.cover),
                                    title: Texts.caption("QRIS",
                                        isBold: true, color: MainColor),
                                    visualDensity: VisualDensity(vertical: -3),
                                    subtitle: Texts.captionSm(
                                        "Kemudahan Pembayaran secara online dari mana saja dengan QRIS",
                                        maxLines: 2),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  splashColor: MainColorGreen,
                                  onTap: () {
                                    getDefaultDialog().onConfirmWithoutIcon(
                                      title:
                                          "Aplikasi akan membuka DG Bankaltimtara",
                                      desc: "Setuju untuk membukanya?",
                                      handler: () {
                                        LaunchApp.openApp(
                                          androidPackageName:
                                              'com.lst.Kaltimtara',
                                          iosUrlScheme: 'pulsesecure://',
                                          appStoreLink:
                                              'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
                                          // openStore: false
                                        );
                                      },
                                    );
                                  },
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/images/dg-kaltim.png",
                                        width: 50.w,
                                        fit: BoxFit.cover),
                                    title: Texts.caption("DG Bankaltimtara",
                                        isBold: true, color: MainColor),
                                    visualDensity: VisualDensity(vertical: -3),
                                    subtitle: Texts.captionSm(
                                        "Kemudahan Pembayaran secara online melalui Aplikasi DG Bankaltimtara",
                                        maxLines: 2),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  splashColor: MainColorGreen,
                                  onTap: () {},
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/images/teller-kaltim.png",
                                        width: 50.w,
                                        fit: BoxFit.cover),
                                    title: Texts.caption("Teller Bankaltimtara",
                                        isBold: true, color: MainColor),
                                    visualDensity: VisualDensity(vertical: -3),
                                    subtitle: Texts.captionSm(
                                        "Pembayaran melalui Teller Bankaltimtara Kantor Badan Pendapatan Daerah Kota Bontang",
                                        maxLines: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                widget: Texts.body1(
                  "Bayar Sekarang",
                ),
                borderSide: true,
                borderSideColor: Colors.cyan,
                gradient: [Colors.cyan, Colors.indigo],
              ),
            )),
      ),
    );
  }
}
