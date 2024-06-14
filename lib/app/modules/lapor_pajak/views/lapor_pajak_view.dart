import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';

import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import '../controllers/lapor_pajak_controller.dart';

class LaporPajakView extends GetView<LaporPajakController> {
  final LaporPajakController controller = Get.find();
  LaporPajakView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Pelaporan Pajak",
        leading: true,
        isLogin: true,
        authModel:controller.authModel
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70.5.h,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColor),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                      topRight: Radius.circular(48),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          offset: Offset(5, 5),
                          color: lightBlueColor.withOpacity(0.4)),
                      BoxShadow(
                          blurRadius: 7,
                          offset: Offset(-2, -2),
                          color: lightBlueColor.withOpacity(0.4))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Daftar Objek Pajak",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              GetBuilder<LaporPajakController>(
                init: LaporPajakController(Get.find<Api>()),
                builder: (controller) {
                  //controller.datalist.length

                  if (controller.isFailed) {
                    return NoData();
                  }

                  if (controller.isEmpty) {
                    return NoData(); //menampilkan lotties no data
                  }

                  if (controller.isLoading) {
                    return ShimmerWidget.Items1();
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.datalist.length,
                      itemBuilder: (context, index) {
                        var dataobjek = controller.datalist[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (dataobjek.status == "0") {
                                  //penginputan WP baru, sedang di verifikasi admin
                                  getDefaultDialog().onFix(
                                      title:
                                          "Mohon maaf data sedang di verifikasi",
                                      desc:
                                          "Silakan tunggu beberapa saat & petugas akan mengirim notifikasi",
                                      kategori: "warning");
                                } else if (dataobjek.status == "2") {
                                  //butuh validasi penginputan pelengkapan data
                                  Get.toNamed(Routes.LENGKAPI_DATA,
                                      arguments: dataobjek);
                                } else if (dataobjek.status == "3") {
                                  //setelah input pelengkapan data, data sedang diverifikasi admin
                                  getDefaultDialog().onFix(
                                      title:
                                          "Mohon maaf data sedang di verifikasi",
                                      desc:
                                          "Silakan tunggu beberapa saat & petugas akan mengirim notifikasi",
                                      kategori: "warning");
                                } else {
                                  controller.PilihPajak(context, dataobjek);
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: Get.height * 0.11,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/listview.png"),
                                              fit: BoxFit.fill),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10,
                                                offset: Offset(8, 6),
                                                color: lightGreenColor
                                                    .withOpacity(0.3)),
                                            BoxShadow(
                                                blurRadius: 10,
                                                offset: Offset(-1, -5),
                                                color: lightGreenColor
                                                    .withOpacity(0.3))
                                          ]),
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 80.h,
                                      margin: EdgeInsets.only(
                                          left: 120, top: 8, right: 17),
                                      child: Column(
                                        children: [
                                          Text(
                                            "",
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold,
                                                color: lightTextColor),
                                          ),
                                          Text(
                                            "${dataobjek.npwpd}",
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: MainColor),
                                          ),
                                          Text(
                                            "${dataobjek.namaUsaha}",
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                color: MainColor),
                                          ),
                                          Text(
                                            "${dataobjek.alamatUsaha}",
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.bold,
                                                color: lightTextColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50.h,
                                      margin: EdgeInsets.only(
                                        top: 20.w,
                                        right: 5.w,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20.sp,
                                          color: lightBlueColor,
                                        ),
                                      ),
                                    ),
                                    dataobjek.status == "0"
                                        ? badges.Badge(
                                            badgeStyle: badges.BadgeStyle(
                                                shape: badges.BadgeShape.square,
                                                badgeColor: Color.fromARGB(
                                                    255, 249, 215, 112),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            badgeContent: Text(
                                                'Proses Verifikasi',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 11)),
                                          )
                                        : dataobjek.status == "3"
                                            ? badges.Badge(
                                                badgeStyle: badges.BadgeStyle(
                                                    shape: badges
                                                        .BadgeShape.square,
                                                    badgeColor: Color.fromARGB(
                                                        255, 249, 215, 112),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                badgeContent: Text(
                                                    'Proses Verifikasi',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 11)),
                                              )
                                            : dataobjek.status == "2"
                                                ? badges.Badge(
                                                    badgeStyle:
                                                        badges.BadgeStyle(
                                                            shape:
                                                                badges
                                                                    .BadgeShape
                                                                    .square,
                                                            badgeColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    249,
                                                                    215,
                                                                    112),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    badgeContent: Text(
                                                        'Mohon Lengkapi Data',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 11)),
                                                  )
                                                : new Container(
                                                    width: 0, height: 0),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: Transform.translate(
                                            offset: Offset(-5, 5),
                                            child: dataobjek.status == "0" ||
                                                    dataobjek.status == "2" ||
                                                    dataobjek.status == "3"
                                                ? Icon(Icons.warning_amber,
                                                    color: Colors.amber)
                                                : Icon(
                                                    Icons
                                                        .check_circle_outline_outlined,
                                                    color: Colors.green)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        );
                      });
                },
              ),
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
                  controller.PilihPendaftaran(context);
                },
                widget: Texts.body2("Tambah NPWPD / Daftar Baru NPWPD",
                    isBold: true),
                borderSide: true,
                borderSideColor: Colors.cyan,
                gradient: [Colors.cyan, Colors.indigo],
              ),
            )),
      ),
    );
  }
}
