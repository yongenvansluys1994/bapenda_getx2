import 'dart:io';

import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/ekitiran_controller.dart';

class EkitiranView extends GetView<EkitiranController> {
  const EkitiranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            "E-Kitiran PBB ${controller.storage.read('user_rt') == null ? "" : "RT ${controller.storage.read('user_rt')['rt']} Kel. ${controller.storage.read('user_rt')['kelurahan']}"}",
        leading: true,
        isLogin: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: GetBuilder<EkitiranController>(
                    init: EkitiranController(),
                    builder: (controller) {
                      if (controller.isFailed) {
                        return ShimmerWidget.Items1();
                      }

                      if (controller.datalist.isEmpty) {
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
                            var datatitem = controller.datalist[index];
                            String formatNop(String nopthn) {
                              // Step 1: Remove the last 4 digits (the year) from nopthn

                              // Step 2: Create formatted NOP as 'xx.xx.xxx.xxx.xxx.xxxx.x'
                              String formattedNop =
                                  "${nopthn.substring(0, 2)}." // xx
                                  "${nopthn.substring(2, 4)}." // xx
                                  "${nopthn.substring(4, 7)}." // xxx
                                  "${nopthn.substring(7, 10)}." // xxx
                                  "${nopthn.substring(10, 13)}." // xxx
                                  "${nopthn.substring(13, 17)}."; // xxxx

                              // Step 3: Add '0' at the end
                              formattedNop += "0";

                              return formattedNop;
                            }

                            return Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      getDefaultDialog().onConfirmWithoutIcon(
                                        title: "Hapus Data Ini?",
                                        desc:
                                            "Apakah anda yakin ingin menghapus data ini ?",
                                        handler: () {
                                          //logInfo(datatitem.nop);
                                          Get.back();
                                          controller.hapusData(datatitem.nop);
                                        },
                                      );
                                    },
                                    backgroundColor:
                                        Color.fromARGB(255, 115, 149, 196),
                                    icon: Icons.delete,
                                    label: 'HAPUS',
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  controller.GetDetailSPPT(datatitem);
                                },
                                child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 1),
                                    child: Container(
                                      height: Get.height * 0.115,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(datatitem
                                                        .statusPembayaranSppt !=
                                                    "BELUM LUNAS"
                                                ? "assets/images/lunas.png"
                                                : "assets/images/belum_bayar.png"),
                                            fit: BoxFit.cover),
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
                                            4, 0, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 15.w,
                                              child: Stack(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, -0.6),
                                                    child: Container(
                                                      width: 12.w,
                                                      height: 12.h,
                                                      decoration: BoxDecoration(
                                                        color: lightBlueColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      VerticalDivider(
                                                        thickness: 2,
                                                        color: lightBlueColor,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 0, 0),
                                              child: Container(
                                                width: 35.w,
                                                height: 35.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF39D2C0),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(2, 2, 2, 2),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.asset(
                                                      'assets/icon/pbb-icon.png',
                                                      width: 90.w,
                                                      height: 90.h,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 10, 0, 1),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 300.w,
                                                          height: 22.h,
                                                          child: Stack(
                                                            children: [
                                                              Texts.caption(
                                                                  'Nama : ${datatitem.nama}'),
                                                              Positioned(
                                                                right: 1,
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .white,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'Tahun ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                Color(0xFF39D2C0),
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            height:
                                                                                0.4,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${datatitem.tahun}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                Color(0xFF39D2C0),
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            height:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'NOP : ${formatNop(datatitem.nop)}',
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color: Color(
                                                                  0xFF57636C),
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Alamat Objek : ${datatitem.alamatOp}',
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color: Color(
                                                                  0xFF57636C),
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(height: 5.h),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${datatitem.jumlahPajak}",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    MainColor),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Buttons.defaultButtonSm(
                                                                fillColor: datatitem
                                                                            .statusPembayaranSppt !=
                                                                        "BELUM LUNAS"
                                                                    ? lightBlueColor
                                                                    : textLink,
                                                                handler:
                                                                    () async {},
                                                                title: datatitem
                                                                            .statusPembayaranSppt !=
                                                                        "BELUM LUNAS"
                                                                    ? 'Lunas'
                                                                    : 'Belum Bayar'),
                                                            Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              color: Color(
                                                                  0xFF57636C),
                                                              size: 24,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            );
                          });
                    },
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    heroTag: "fab1", // Hero tag unik
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      child: Icon(
                        Icons.settings,
                        size: 40,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: gradientColor)),
                    ),
                    onPressed: () {
                      controller.showBottomSheet(flag: "edit");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "fab2", // Hero tag unik
        child: Container(
          width: 60.w,
          height: 60.h,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: gradientColor)),
        ),
        onPressed: () {
          Get.toNamed(
            Routes.EKITIRAN_FORM,
            arguments: {
              "rtModel": controller.rtModel,
            },
          );
        },
      ),
    );
  }
}
