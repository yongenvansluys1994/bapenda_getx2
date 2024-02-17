import 'dart:io';

import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/core/pdf/pdf_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoicePdfHelper {
  static Future<File> generate(ModelGetpelaporanUser laporan) async {
    int? persenDenda;
    int? denda_pajak;
    DateTime dateBayar = laporan.tanggalLunas == "0"
        ? DateTime.now()
        : DateTime.parse("${laporan.tanggalLunas}");
    DateTime dateBatasBayar = laporan.batasBayar;
    Duration? interval;
    interval = dateBayar.difference(dateBatasBayar);
    int selisih = interval.inDays;
    int daysPerStep = 30; // Number of days for each step
    int maxDenda = 48; // Maximum denda value
    int steps = (selisih / daysPerStep).floor();

    int amount = int.parse(laporan.pajak); // Replace with the actual amount
    persenDenda = (steps * 2).clamp(0, maxDenda);
    denda_pajak = (amount * persenDenda / 100).toInt();
    int totalPajak = (denda_pajak + int.parse(laporan.pajak));

    final pdf = Document();
    String svgRaw =
        await rootBundle.loadString('assets/images/logo-bontang.svg');
    final svgImage = pw.SvgImage(svg: svgRaw);
    String svgRaw2 =
        await rootBundle.loadString('assets/images/logo-bontang.svg');
    final svgImage2 = pw.SvgImage(svg: svgRaw2);

    pdf.addPage(MultiPage(
      build: (context) => [
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Stack(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 88.w, height: 88.h, child: svgImage),
            SizedBox(width: 10.w),
          ]),
          Positioned(
              left: 77.r,
              child: Container(
                width: 13.4 * PdfPageFormat.cm,
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Text("PEMERINTAH KOTA BONTANG",
                        style: TextStyle(fontSize: 18.sp)),
                    Text("BADAN PENDAPATAN DAERAH",
                        style: TextStyle(fontSize: 18.sp)),
                    Text(
                        "Jl. MH. Thamrin RT. 05 No. 14 Telpon (0548) 21301, 21152 Fax. (0548) 21152",
                        style: TextStyle(fontSize: 9.5.sp)),
                    //Text("BONTANG", style: TextStyle(fontSize: 13))
                  ],
                ),
              ))
        ]),
        Stack(children: [
          Center(
              child: Column(children: [
            SizedBox(height: 30.h),
            Container(
                width: 600.w,
                height: 600.h,
                child: Opacity(opacity: 0.1, child: svgImage2))
          ])),
          Container(
              child: Column(children: [
            Divider(),
            buildHeader(laporan),
            SizedBox(height: 1 * PdfPageFormat.cm),
            buildTitle(laporan),
            Divider(),
            buildBody(laporan, persenDenda!, denda_pajak!, totalPajak),
            Divider(),
            buildTtd(laporan),
          ]))
        ]),
      ],
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      footer: (context) => buildFooter(),
    ));

    return PdfHelper.saveDocument(
        name:
            'Bukti_Setor_${laporan.namaUsaha.replaceAll('/', '')}_${laporan.masaPajak}.pdf',
        pdf: pdf);
  }

  static Widget buildHeader(ModelGetpelaporanUser laporan) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("BUKTI SETOR", style: TextStyle(fontSize: 18))],
          ),
        ],
      );

  static Widget buildTitle(ModelGetpelaporanUser laporan) => Container(
        width: 500.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama", style: TextStyle(fontSize: 11.sp)),
                      Text("Alamat", style: TextStyle(fontSize: 11.sp)),
                      Text("NPWPD", style: TextStyle(fontSize: 11.sp)),
                      Text("Tanggal Jatuh Tempo",
                          style: TextStyle(fontSize: 11.sp)),
                    ],
                  ),
                ),
                Container(
                  width: 700.w * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(": ${laporan.namaUsaha}",
                          style: TextStyle(fontSize: 11.sp)),
                      Text(": ${laporan.alamatUsaha}",
                          style: TextStyle(fontSize: 11.sp)),
                      Text(": ${laporan.npwpd}",
                          style: TextStyle(fontSize: 11.sp)),
                      Text(
                          ": ${DateFormat('dd/MM/yyyy').format(laporan.batasBayar)} ",
                          style: TextStyle(fontSize: 11.sp)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  static Widget buildBody(ModelGetpelaporanUser laporan, int persenDenda,
          int denda_pajak, int totalPajak) =>
      Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(130.w),
          border: TableBorder.all(style: BorderStyle.solid, width: 1),
          children: [
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(
                      'Jenis Pajak Daerah',
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(
                      'Jumlah',
                    ),
                  )
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text('${laporan.jenispajak}'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(
                        '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(laporan.pajak.toString()))}'),
                  )
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text('${laporan.jenispajak}'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(''),
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(
                        'Masa : ${laporan.masaPajak2} s/d ${laporan.masaAkhir2}'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(''),
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text('Judul : ${laporan.namaUsaha}'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(''),
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text('Lokasi : ${laporan.alamatUsaha}'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(''),
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(
                        '(${NumberFormat.currency(locale: 'id', symbol: '').format(int.parse(laporan.pendapatan.toString()))} * ${laporan.tarifPersen})'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(''),
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text('Jumlah Ketetapan Pokok Pajak'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(
                        '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(laporan.pajak.toString()))}'),
                  )
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text('Denda ${persenDenda}%'),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(
                        '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(denda_pajak.toString()))}'),
                  )
                ],
              ),
            ]),
            TableRow(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 0, 7),
                    child: Text(' '),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 2, 0, 2),
                    child: Text('Total'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 2, 0, 2),
                    child: Text(
                        '${NumberFormat.currency(locale: 'id', symbol: 'Rp. ').format(int.parse(totalPajak.toString()))}'),
                  )
                ],
              ),
            ]),
          ],
        ),
      );
  static Widget buildTtd(ModelGetpelaporanUser laporan) =>
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Text("Kabid Pelayanan Pajak Daerah"),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Container(
            height: 50,
            width: 50,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: "${laporan.nomorKohir}",
            ),
          ),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text("Yasur S.Sos")
        ])
      ]);

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
                  "Bukti Setor Resmi Badan Pendapatan Daerah Kota Bontang yang dikeluarkan oleh Aplikasi My Bapenda",
                  style: TextStyle(fontSize: 8)),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              Text(
                  "Simpan Bukti Setor ini untuk menjadi bukti Lunas Pembayaran",
                  style: TextStyle(fontSize: 8)),
            ],
          ),
        ],
      );
}
