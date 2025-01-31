import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/pbb_controller.dart';

class PbbView extends GetView<PbbController> {
  const PbbView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "E-PBB P2",
          leading: true,
          isLogin: true,
        ),
        body: GestureDetector(
          onTap: () {
            dismissKeyboard();
          },
          child: GetBuilder<PbbController>(
              init: PbbController(),
              builder: (controller) {
                return Column(
                  children: [
                    Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColor),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Texts.body1("Masukkan NOP dan lihat Daftar Piutang",
                              color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Texts.caption("NOP",
                                      isBold: true, color: Colors.white),
                                ),
                                Container(
                                  child: TextFormField(
                                    controller: controller.nop,
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(height: 0),
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 30, 10, 0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '64.74.010.xxx.xxx.xxxx.0',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: lightGreenColor, width: 2),
                                      ),
                                    ),
                                    inputFormatters: [controller.maskFormatter],
                                    keyboardType: TextInputType.number,
                                  ),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 164, 186, 206),
                                      blurRadius: 5,
                                      offset: Offset(-2, -2),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      height: 40.h,
                      width: 100.w,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradientColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              "Cari NOP",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            onPressed: () {
                              easyThrottle(
                                handler: () {
                                  controller.fetchData();
                                },
                              );
                            }),
                      ),
                    ),
                    GetBuilder<PbbController>(
                        init: PbbController(),
                        builder: (controller) {
                          if (controller.isError) {
                            return NoData();
                          }
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.datalist.length,
                              itemBuilder: (context, index) {
                                var dataInformasi = controller.dataInformasi;
                                var spptItem = controller.datalist[index];
                                String formatNop(String nopthn) {
                                  // Step 1: Remove the last 4 digits (the year) from nopthn
                                  String nopWithoutYear =
                                      nopthn.substring(0, nopthn.length - 4);

                                  // Step 2: Create formatted NOP as 'xx.xx.xxx.xxx.xxx.xxxx.x'
                                  String formattedNop =
                                      "${nopWithoutYear.substring(0, 2)}." // xx
                                      "${nopWithoutYear.substring(2, 4)}." // xx
                                      "${nopWithoutYear.substring(4, 7)}." // xxx
                                      "${nopWithoutYear.substring(7, 10)}." // xxx
                                      "${nopWithoutYear.substring(10, 13)}." // xxx
                                      "${nopWithoutYear.substring(13, 17)}."; // xxxx

                                  // Step 3: Add '0' at the end
                                  formattedNop += "0";

                                  return formattedNop;
                                }

                                return InkWell(
                                  onTap: () {
                                    //GetDialogContent(item, totalPajak, denda_pajak);
                                  },
                                  child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 1),
                                      child: Container(
                                        height: Get.height * 0.115,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(spptItem
                                                          .statusPembayaran !=
                                                      "BELUM BAYAR"
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, -0.6),
                                                      child: Container(
                                                        width: 12.w,
                                                        height: 12.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: lightBlueColor,
                                                          shape:
                                                              BoxShape.circle,
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
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                2, 2, 2, 2),
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                    'Nama : ${controller.dataInformasi.value.namaWp}'),
                                                                Positioned(
                                                                  right: 1,
                                                                  child:
                                                                      Padding(
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
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Tahun ',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Outfit',
                                                                              color: Color(0xFF39D2C0),
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.bold,
                                                                              height: 0.4,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${spptItem.tahunPajak}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Outfit',
                                                                              color: Color(0xFF39D2C0),
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.bold,
                                                                              height: 1,
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
                                                        child: Text(
                                                          'Jenis Pajak : PBB \n NOP : ${formatNop(spptItem.nopthn)}',
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow.clip,
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
                                                      ),
                                                      Divider(height: 5.h),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              NumberFormat.currency(
                                                                      locale:
                                                                          'id',
                                                                      symbol:
                                                                          'Rp. ',
                                                                      decimalDigits:
                                                                          0)
                                                                  .format(int.parse(spptItem
                                                                              .statusPembayaran !=
                                                                          "BELUM BAYAR"
                                                                      ? spptItem
                                                                          .jumlahTelahBayar
                                                                      : spptItem
                                                                          .jumlahHarusBayar)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      MainColor),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Buttons
                                                                  .defaultButtonSm(
                                                                      fillColor: spptItem.statusPembayaran !=
                                                                              "BELUM BAYAR"
                                                                          ? lightBlueColor
                                                                          : textLink,
                                                                      handler:
                                                                          () async {
                                                                        Get.toNamed(
                                                                            Routes.QRISPBB,
                                                                            arguments: [
                                                                              spptItem.nopthn,
                                                                              spptItem.jumlahHarusBayar
                                                                            ]);
                                                                        if (spptItem.statusPembayaran !=
                                                                            "BELUM BAYAR") {
                                                                        } else {}
                                                                      },
                                                                      title: spptItem.statusPembayaran !=
                                                                              "BELUM BAYAR"
                                                                          ? 'Bukti Bayar'
                                                                          : 'SPPT'),
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
                                );
                              });
                        })
                  ],
                );
              }),
        ));
  }
}
