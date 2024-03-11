import 'dart:io';

import 'package:bapenda_getx2/app/modules/parkir_app/models/model_parkir_lhp.dart';
import 'package:bapenda_getx2/core/pdf/pdf_helper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfLHPParkirHelper {
  static Future<File> generate(
      RxList<ModelParkirLhp> laporan,
      DateTime? selectedDate,
      DateTime? selectedDate_akhir,
      String namaUsaha) async {
    final pdf = Document();

    const pageSize = 32;

    Map<int, List<pw.TableRow>> rows = {};

    final numberOfPages = (laporan.length / pageSize).ceil();

    for (var page = 0; page < numberOfPages; page++) {
      rows[page] = [
        pw.TableRow(
          children: [
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("No.",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Nama Usaha",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Jenis",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Nominal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text("Tanggal",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ),
          ],
        ),
      ];

      var loopLimit =
          laporan.length - (laporan.length - ((page + 1) * pageSize));

      if (loopLimit > laporan.length) loopLimit = laporan.length;

      for (var index = pageSize * page; index < loopLimit; index++) {
        rows[page]!.add(pw.TableRow(
          children: [
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${index + 1}",
                ),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${laporan[index].namaUsaha.substring(0, 15) ?? ""} ",
                ),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  laporan[index].jenis ?? "",
                ),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(laporan[index].nominal))}",
                ),
              ),
            ),
            pw.Container(
              height: 20.h,
              child: pw.Center(
                child: pw.Text(
                  "${DateFormat('yyyy-MM-dd HH:mm:ss').format(laporan[index].date)}" ??
                      "",
                ),
              ),
            ),
          ],
        ));
      }
    }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(horizontal: PdfPageFormat.cm * 1),
        header: (context) =>
            buildHeader(selectedDate, selectedDate_akhir, namaUsaha),
        footer: (context) => buildFooter(),
        maxPages: 100,
        build: (context) {
          return List<pw.Widget>.generate(rows.keys.length, (index) {
            return pw.Column(
              children: [
                pw.Table(
                  border:
                      pw.TableBorder.all(color: PdfColor.fromHex("#000000")),
                  children: rows[index]!,
                ),
              ],
            );
          });
        },
      ),
    );

    // pdf.addPage(MultiPage(
    //   build: (context) => [
    //     SizedBox(height: 0.8 * PdfPageFormat.cm),
    //     Stack(children: [
    //       Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //         Container(width: 88.w, height: 88.h, child: svgImage),
    //         SizedBox(width: 10.w),
    //       ]),
    //       Positioned(
    //           left: 77.r,
    //           child: Container(
    //             width: 13.4 * PdfPageFormat.cm,
    //             child: Column(
    //               children: [
    //                 SizedBox(height: 15.h),
    //                 Text("LHP Pajak Bulan Desember",
    //                     style: TextStyle(fontSize: 18.sp)),
    //                 Text("BADAN PENDAPATAN DAERAH",
    //                     style: TextStyle(fontSize: 18.sp)),
    //                 Text(
    //                     "Jl. MH. Thamrin RT. 05 No. 14 Telpon (0548) 21301, 21152 Fax. (0548) 21152",
    //                     style: TextStyle(fontSize: 9.5.sp)),
    //                 //Text("BONTANG", style: TextStyle(fontSize: 13))
    //               ],
    //             ),
    //           ))
    //     ]),
    //     Stack(children: [
    //       Center(
    //           child: Column(children: [
    //         SizedBox(height: 30.h),
    //         Container(
    //             width: 600.w,
    //             height: 600.h,
    //             child: Opacity(opacity: 0.1, child: svgImage2))
    //       ])),
    //       Container(
    //           child: Column(children: [
    //         Divider(),
    //         SizedBox(height: 1 * PdfPageFormat.cm),
    //         buildBody(laporan),
    //       ]))
    //     ]),
    //   ],
    //   margin: EdgeInsets.symmetric(horizontal: 50.w),
    //   footer: (context) => buildFooter(),
    // ));

    return PdfHelper.saveDocument(name: 'Cetak_LHP.pdf', pdf: pdf);
  }

  static Widget buildBody(RxList<ModelParkirLhp> laporan) => Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: ListView.builder(
          itemCount: laporan.length,
          itemBuilder: (context, index) {
            var dataitem = laporan[index];
            return Container(
              height: 20.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 110.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(dataitem.npwpd)],
                    ),
                  ),
                  Container(
                    width: 55.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(dataitem.jenis)],
                    ),
                  ),
                  Container(
                    width: 60.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(dataitem.nominal))}")
                      ],
                    ),
                  ),
                  Container(
                    width: 130.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${DateFormat('yyyy-MM-dd HH:mm:ss').format(dataitem.date)}")
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

  static Widget buildHeader(DateTime? selectedDate,
          DateTime? selectedDate_akhir, String namaUsaha) =>
      Center(
          child: Container(
              child: Column(
        children: [
          SizedBox(height: 15.h),
          Text("LHP Pajak ${namaUsaha}",
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
          Text("By Bapenda Etam App",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
          Text(
              "Periode : ${DateFormat('dd-MM-yyyy').format(selectedDate!)} - ${DateFormat('dd-MM-yyyy').format(selectedDate_akhir!)}",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          //Text("BONTANG", style: TextStyle(fontSize: 13))
        ],
      )));

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              Text(
                  "LHP ini adalah resmi dikeluarkan oleh Aplikasi Bapenda Etam dan diakui oleh Badan Pendapatan Daerah Kota Bontang",
                  style: TextStyle(fontSize: 9.sp)),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              Text("Download PDF ini untuk menyimpannya kedalam Ponsel",
                  style: TextStyle(fontSize: 9.sp)),
            ],
          ),
          SizedBox(height: 2 * PdfPageFormat.mm),
        ],
      );
}
