import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/pembayaran_controller.dart';

class PembayaranView extends GetView<PembayaranController> {
  const PembayaranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Pembayaran Pajak",
          leading: true,
          isLogin: true,
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
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
                        "Daftar Invoice Menunggu Pembayaran",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GetBuilder<PembayaranController>(
                init: PembayaranController(Get.find<Api>()),
                builder: (controller) {
                  if (controller.isFailed) {
                    return ShimmerWidget.Items1();
                  }

                  if (controller.isEmpty) {
                    return NoData(); //menampilkan lotties no data
                  }

                  if (controller.isLoading) {
                    return ShimmerWidget.Items1();
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: controller.datalist.length,
                      itemBuilder: (context, index) {
                        var item = controller.datalist[index];

                        return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                            child: Container(
                              height: 120.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/belum_bayar.png"),
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
                                    EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 15.w,
                                      child: Stack(
                                        alignment: AlignmentDirectional(0, 0),
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, -0.6),
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
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: Container(
                                        width: 35.w,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF39D2C0),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  2, 2, 2, 2),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.asset(
                                              'assets/icon/hotel.png',
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 10, 0, 1),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 300.w,
                                                  height: 30.h,
                                                  child: Stack(
                                                    children: [
                                                      Texts.caption(
                                                          '${item.namaUsaha}'),
                                                      Positioned(
                                                        right: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(8,
                                                                      0, 0, 0),
                                                          child: Container(
                                                            color: Colors.white,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Periode ',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: Color(
                                                                        0xFF39D2C0),
                                                                    fontSize:
                                                                        8.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    height: 0.5,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${item.masaPajak}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: Color(
                                                                        0xFF39D2C0),
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              child: Text(
                                                'Jenis Pajak : ${item.nmRekening} \n NPWPD : ${item.npwpd}',
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Divider(height: 5.h),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    NumberFormat.currency(
                                                            locale: 'id',
                                                            symbol: 'Rp. ',
                                                            decimalDigits: 0)
                                                        .format(int.parse(item
                                                            .pajak
                                                            .toString())),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        fontFamily: 'Outfit',
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: MainColor),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Buttons.defaultButtonSm(
                                                        fillColor: textLink,
                                                        handler: () {
                                                          Get.toNamed(
                                                              Routes.EBILLING,
                                                              arguments: item);
                                                        },
                                                        title: item.tanggalLunas !=
                                                                "0"
                                                            ? 'Bukti Setor'
                                                            : 'Lihat E-Billing'),
                                                    Icon(
                                                      Icons
                                                          .chevron_right_rounded,
                                                      color: Color(0xFF57636C),
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
                            ));
                      });
                },
              ),
            ],
          ),
        ));
  }
}
