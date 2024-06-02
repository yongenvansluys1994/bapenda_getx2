import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/controllers/pelaporan_history_controller.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/core/pdf/pdf_helper.dart';
import 'package:bapenda_getx2/core/pdf/pdf_invoice_helper.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryPajak5 extends StatelessWidget {
  HistoryPajak5({super.key, required String id_wajib_pajak});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PelaporanHistoryController>(
      init: PelaporanHistoryController(Get.find<Api>()),
      builder: (controller) {
        if (controller.isFailed) {
          return SizedBox(height: 150.h, child: ShimmerWidget.Items1());
        }

        if (controller.isEmpty5) {
          return NoData(); //menampilkan lotties no data
        }

        if (controller.isLoading) {
          return SizedBox(height: 150.h, child: ShimmerWidget.Items1());
        }
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: controller.datalist5.length,
            itemBuilder: (context, index) {
              var item = controller.datalist5[index];
              //start perhitungan denda
              int? persenDenda;
              int? denda_pajak;
              int? totalPajak;
              DateTime dateNow = DateTime.now();
              DateTime dateBatasBayar = item.batasBayar;
              Duration? interval;
              interval = item.tanggalLunas == "0"
                  ? dateNow.difference(dateBatasBayar)
                  : DateTime.parse(item.tanggalLunas)
                      .difference(dateBatasBayar);
              int selisih = interval.inDays;
              int daysPerStep = 30; // Number of days for each step
              int maxDenda = 48; // Maximum denda value
              int steps = (selisih / daysPerStep).floor();

              int amount =
                  int.parse(item.pajak); // Replace with the actual amount
              persenDenda = (steps * 2).clamp(0, maxDenda);
              denda_pajak = (amount * persenDenda / 100).toInt();
              totalPajak = (denda_pajak + int.parse(item.pajak));
              //end perhitungan denda
              return InkWell(
                onTap: () {
                  GetDialogContent(item, totalPajak, denda_pajak);
                },
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                    child: Container(
                      height: Get.height * 0.133,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(item.status == "0"
                                ? "assets/images/putih_polos.png"
                                : item.tanggalLunas != "0"
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
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
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
                                    alignment: AlignmentDirectional(0, -0.6),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Container(
                                width: 35.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF39D2C0),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2, 2, 2, 2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                      'assets/icon/${controller.nmassets}.png',
                                      width: 90.w,
                                      height: 90.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 10, 0, 1),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 0, 0),
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Periode ',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Color(
                                                                0xFF39D2C0),
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 0.5,
                                                          ),
                                                        ),
                                                        Text(
                                                          '${item.masaPajak}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Color(
                                                                0xFF39D2C0),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: item.status == "0"
                                          ? Text(
                                              'Data Laporan Pajak Sedang \ndi Verifikasi Petugas.',
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color.fromARGB(
                                                    255, 233, 175, 1),
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            )
                                          : Text(
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
                                          child: item.status == "0"
                                              ? Text(
                                                  "Rp. xxx",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      fontFamily: 'Outfit',
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: MainColor),
                                                )
                                              : Text(
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
                                                isDisabled:
                                                    item.nomorKohir == "0"
                                                        ? true
                                                        : false,
                                                fillColor:
                                                    item.tanggalLunas != "0"
                                                        ? lightBlueColor
                                                        : textLink,
                                                handler: () async {
                                                  final pdfFile =
                                                      await PdfInvoicePdfHelper
                                                          .generate(controller
                                                                  .datalist5[
                                                              index]);

                                                  item.tanggalLunas != "0"
                                                      ? PdfHelper.openFile(
                                                          pdfFile)
                                                      : item.nomorKohir == "0"
                                                          ? EasyLoading.showToast(
                                                              "E-Billing belum tersedia, sedang diverif petugas")
                                                          : Get.toNamed(
                                                              Routes.EBILLING,
                                                              arguments: controller
                                                                      .datalist5[
                                                                  index]);
                                                },
                                                title: item.tanggalLunas != "0"
                                                    ? 'Bukti Setor'
                                                    : 'Lihat E-Billing'),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color.fromARGB(
                                                  255, 55, 61, 66),
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
      },
    );
  }
}
