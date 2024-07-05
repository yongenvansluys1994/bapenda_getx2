import 'dart:io';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/myprofil/controllers/myprofil_controller.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;

import 'package:get/get.dart';

class AdsPage extends GetView<MyprofilController> {
  const AdsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Promosi & Iklan",
          leading: true,
          isLogin: true,
        ),
        body: GestureDetector(
            onTap: () => dismissKeyboard(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<MyprofilController>(
                    init: MyprofilController(Get.find<Api>()),
                    builder: (controller) {
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: Column(
                          children: [
                            Center(
                                child: Texts.caption(
                                    "Form Pengajuan Promosi/Banner",
                                    isBold: true)),
                            SizedBox(height: 10.h),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 16),
                                child: Form(
                                  key: controller.formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 15),
                                            Container(
                                              child: TextFormField(
                                                controller:
                                                    controller.nama_usaha,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12, 12, 12, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText:
                                                      'Masukan Nama Usaha ',
                                                  labelText: 'Nama Usaha *',
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightGreenColor,
                                                        width: 2),
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 164, 186, 206),
                                                  blurRadius: 2,
                                                ),
                                              ]),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              child: TextFormField(
                                                controller:
                                                    controller.judul_promosi,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12, 12, 12, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText:
                                                      'Masukan Judul Promosi ',
                                                  labelText: 'Judul Promosi *',
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightGreenColor,
                                                        width: 2),
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 164, 186, 206),
                                                  blurRadius: 2,
                                                ),
                                              ]),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              child: TextFormField(
                                                controller:
                                                    controller.deskripsi,
                                                minLines:
                                                    5, // any number you need (It works as the rows for the textarea)
                                                keyboardType:
                                                    TextInputType.multiline,
                                                textInputAction:
                                                    TextInputAction.newline,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12, 12, 12, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText:
                                                      'Masukan Deskripsi Promosi',
                                                  labelText:
                                                      'Deskripsi Promosi/Banner *',
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightGreenColor,
                                                        width: 2),
                                                  ),
                                                ),
                                              ),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 164, 186, 206),
                                                  blurRadius: 2,
                                                ),
                                              ]),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    "Upload Gambar/Thumbnail :",
                                                  ),
                                                ),
                                                Container(
                                                  width: 150.w,
                                                  height: 75.h,
                                                  child:
                                                      (controller.imageFile ==
                                                              null)
                                                          ? Text("")
                                                          : Image.file(File(
                                                              controller
                                                                  .imageFile!
                                                                  .path)),
                                                ),
                                                SizedBox(
                                                  width: 110.w,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .openGallery(context);
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      64,
                                                                      64,
                                                                      64)),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.camera_alt,
                                                            size: 20),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          'Pilih Gambar',
                                                          style: TextStyle(
                                                              fontSize: 9.sp),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 110.w,
                                            child: OutlinedButton.icon(
                                                //Handle button press event
                                                onPressed: () {
                                                  easyThrottle(
                                                    handler: () {
                                                      controller.simpanData();
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  side: const BorderSide(
                                                    color: lightBlueColor,
                                                    width: 1,
                                                  ),
                                                  onPrimary: lightBlueColor,
                                                ),
                                                icon:
                                                    const Icon(Icons.save_alt),
                                                label: const Text("Simpan")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Banner Promosi Anda",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                  ),
                  GetBuilder<MyprofilController>(
                    init: MyprofilController(Get.find<Api>()),
                    builder: (controller) {
                      if (controller.isFailed) {
                        return ShimmerWidget.Items1();
                      }

                      if (controller.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 130.r),
                          child: NoData(),
                        ); //menampilkan lotties no data
                      }

                      if (controller.isLoading) {
                        return ShimmerWidget.Items1();
                      }
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.r),
                            child: SizedBox(
                              width: 350.w,
                              height: 115.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.datalist.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(2),
                                  itemBuilder: (context, index) {
                                    var dataitem = controller.datalist[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.ADS_DETAIL,
                                            arguments: dataitem);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w),
                                                  child: Image.network(
                                                    "http://simpatda.bontangkita.id/upload/${dataitem.urlImage}", // "${URL_APP}/upload/${dataitem.urlImage}",
                                                    height: 80.h,
                                                    width: 110.w,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                SizedBox(
                                                  width: 110.w,
                                                  child: Texts.captionSm(
                                                    "${dataitem.judul}",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 2.w),
                                            child: badges.Badge(
                                              badgeStyle: badges.BadgeStyle(
                                                  shape:
                                                      badges.BadgeShape.square,
                                                  badgeColor: dataitem.status ==
                                                          0
                                                      ? Color.fromARGB(
                                                          255, 249, 215, 112)
                                                      : correctData,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              badgeContent: Text(
                                                  dataitem.status == '0'
                                                      ? 'Proses Verifikasi'
                                                      : 'Aktif',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            )));
  }
}
