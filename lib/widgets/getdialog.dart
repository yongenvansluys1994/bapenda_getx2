import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_store/open_store.dart';

class getDefaultDialog {
  void onConfirm({
    required String title,
    required String desc,
    required String kategori,
    required VoidCallback handler,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 100.w, repeat: false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Tidak"),
            borderSide: false,
            gradient: [
              Colors.pinkAccent.withOpacity(0.8),
              Colors.redAccent.withOpacity(0.7)
            ],
          ),
        ),
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: handler,
            widget: Texts.button("Ya"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.greenAccent],
          ),
        ),
      ],
    );
  }

  void onConfirmWithoutIcon({
    required String title,
    required String desc,
    required VoidCallback handler,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.r, horizontal: 7.r),
            child: Text(
              "${title}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Tidak"),
            borderSide: false,
            gradient: [
              Colors.pinkAccent.withOpacity(0.8),
              Colors.redAccent.withOpacity(0.7)
            ],
          ),
        ),
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: handler,
            widget: Texts.button("Ya"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.greenAccent],
          ),
        ),
      ],
    );
  }

  void onFix({
    required String title,
    required String desc,
    required String kategori,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 120.w, repeat: false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.r, horizontal: 10.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Ok"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.indigo],
          ),
        ),
      ],
    );
  }

  void onFixWithHandler({
    required String title,
    required String desc,
    required String kategori,
    required VoidCallback handler,
  }) {
    Get.defaultDialog(
      barrierDismissible: false,
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Lottie.asset('assets/lottie/${kategori}.json',
              width: 120.w, repeat: false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.r, horizontal: 10.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: handler,
            widget: Texts.button("Ok"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.indigo],
          ),
        ),
      ],
    );
  }

  void onFixWithoutIcon({
    required String title,
    required String desc,
  }) {
    Get.defaultDialog(
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.r),
            child: Text(
              "${title}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.r),
            child: Text(
              "${desc}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Ok"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.indigo],
          ),
        ),
      ],
    );
  }

  void BannerDashboard({
    required String title,
    required String desc,
  }) {
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        titlePadding: EdgeInsets.zero,
        content: Stack(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/images/banner.png",
                width: 280.w,
              ),
            ),
            Positioned(
              right: 10.w,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 28.sp,
                  height: 28.sp,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x2B202529),
                        offset: Offset(0, 2),
                      )
                    ],
                    shape: BoxShape.circle,
                  ),
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Icon(
                    Icons.cancel_outlined,
                    color: MainColor,
                    size: 26.sp,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

void GetDialogDismissible(
    {required int currentversion, required String DBVersion}) {
  Get.defaultDialog(
    barrierDismissible: false,
    title: "",
    // titleStyle: TextStyle(fontSize: 20.sp),
    titlePadding: EdgeInsets.all(0),
    content: Column(
      children: [
        Lottie.asset('assets/lottie/error.json', width: 120.w, repeat: true),
        Text(
          'Update Versi Terbaru Tersedia!',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10.h),
        Text(
          'Versi Terbaru 1.${DBVersion} Aplikasi telah tersedia, Versi Anda sekarang adalah 1.${currentversion}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.sp),
        ),
        Text(
          'Silahkan klik tombol Update.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.sp),
        ),
      ],
    ),
    contentPadding: EdgeInsets.only(bottom: 10, top: 0),
    radius: 10,
    actions: [
      SizedBox(
        width: 100.w,
        child: Buttons.gradientButton(
          handler: () {
            OpenStore.instance.open(
              appStoreId: '284815942',
              androidAppBundleId: 'com.yongenbisa.mybapenda',
            );
          },
          widget: Texts.button("Update"),
          borderSide: false,
          gradient: [Colors.cyan, Colors.greenAccent],
        ),
      ),
    ],
  );
}

void GetDialogContent(
    ModelGetpelaporanUser item, int? totalPajak, int? denda_pajak) {
  Get.defaultDialog(
    radius: 12.r,
    titlePadding: EdgeInsets.zero,
    content: Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  topRight: Radius.circular(10.w)),
            ),
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "NAMA",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.namaUsaha}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 0.5.w),
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "NPWPD",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.npwpd}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 248, 248, 248)),
            height: 40.h,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 230.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "ALAMAT",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.alamatUsaha}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
            ),
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "Jenis Pajak",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.nmRekening}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 0.5.w),
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "No. Kohir",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.nomorKohir}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 248, 248, 248),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  topRight: Radius.circular(10.w)),
            ),
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "Periode Awal",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.masaPajak2}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 0.5.w),
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "Periode Akhir",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.masaAkhir2}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
            ),
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "Jml Pajak",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.pajak}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 0.5.w),
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "Denda",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${denda_pajak}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 248, 248, 248),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  topRight: Radius.circular(10.w)),
            ),
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "Batas Bayar",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${DateFormat('yyyy-MM-dd').format(item.batasBayar)}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 0.5.w),
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Container(
                    width: 115.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.captionXs(
                          "Tanggal Lunas",
                          isBold: true,
                          color: Color.fromARGB(255, 71, 80, 90),
                        ),
                        Texts.captionXs(
                          "${item.tanggalLunas}",
                          color: Color.fromARGB(255, 59, 59, 59),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    actions: [
      SizedBox(
        width: 80.w,
        child: Buttons.gradientButton(
          handler: () {
            Get.back();
          },
          widget: Texts.button("Ok"),
          borderSide: false,
          gradient: [Colors.cyan, Colors.indigo],
        ),
      ),
    ],
  );
}