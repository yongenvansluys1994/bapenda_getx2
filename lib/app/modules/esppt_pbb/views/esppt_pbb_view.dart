import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/divider.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/topline_bottomsheet%20copy.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/esppt_pbb_controller.dart';

class EspptPbbView extends GetView<EspptPbbController> {
  const EspptPbbView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "E-SPPT PBB", leading: true, isLogin: true),
      body: GetBuilder<EspptPbbController>(
        init: EspptPbbController(),
        builder: (controller) {
          if (controller.isLoading) {
            return NoData();
          }
          return Column(
            children: [
              Center(
                child: Container(
                  width: 320.w, // full width layar
                  height: 65.h, // tinggi 15% dari tinggi layar
                  child: Row(
                    children: [
                      // Container pertama dengan border kanan
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                              right: BorderSide(
                                  color: Colors.black), // Border kanan
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.5.sp, horizontal: 3.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child:
                                        Texts.textESPPT('LETAK OBJEK PAJAK')),
                                Texts.textESPPT('JL MENTE'),
                                Texts.textESPPT('RT: 004 RW:000'),
                                Texts.textESPPT('TANJUNG LAUT'),
                                Texts.textESPPT('BONTANG SELATAN'),
                                Texts.textESPPT('BONTANG'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Container kedua tanpa border kiri
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black),
                            ), // Border hitam tanpa border kiri
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.5.sp, horizontal: 3.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Texts.textESPPT(
                                        'NAMA DAN ALAMAT WAJIB PAJAK')),
                                Texts.textESPPT('MARDIAH'),
                                Texts.textESPPT('JL MENTE'),
                                Texts.textESPPT('RT: 004 RW:000'),
                                Texts.textESPPT('TANJUNG LAUT'),
                                Texts.textESPPT('BONTANG'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 320.w, // full width layar
                  // tinggi 15% dari tinggi layar
                  child: Row(
                    children: [
                      tableHead(
                        text: 'OBJEK PAJAK',
                        left: true,
                        bottom: true,
                        right: true,
                        width: 58.w,
                        textAlign: TextAlign.center,
                      ),
                      tableHead(
                        text: 'LUAS (M2)',
                        bottom: true,
                        right: true,
                        width: 53.w,
                        textAlign: TextAlign.center,
                      ),
                      tableHead(
                        text: 'KELAS',
                        bottom: true,
                        right: true,
                        width: 31.w,
                        textAlign: TextAlign.center,
                      ),
                      tableHead(
                        text: 'NJOP PER M2 (Rp)',
                        bottom: true,
                        right: true,
                        width: 89.w,
                        textAlign: TextAlign.center,
                      ),
                      tableHead(
                        text: 'TOTAL NJOP (Rp)',
                        bottom: true,
                        right: true,
                        width: 89.w,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Data tabel
              Center(
                child: Container(
                  width: 320.w, // full width layar
                  height: 40.h,
                  child: Row(
                    children: [
                      tableData(
                        data: ['Bumi', 'Bangunan'], // Data kolom pertama
                        left: true,
                        bottom: true,
                        right: true,
                        width: 58.w,
                        textValign: MainAxisAlignment.center,
                        textAlign: TextAlign.left,
                      ),
                      tableData(
                        data: ['100', '200'], // Data kolom kedua
                        bottom: true,
                        right: true,
                        textValign: MainAxisAlignment.center,
                        width: 53.w, textAlign: TextAlign.right,
                      ),
                      tableData(
                        data: ['075', '027'], // Data kolom ketiga
                        bottom: true,
                        right: true,
                        textValign: MainAxisAlignment.center,
                        width: 31.w, textAlign: TextAlign.right,
                      ),
                      tableData(
                        data: ['1.000.000', '2.000.000'], // Data kolom keempat
                        bottom: true,
                        right: true,
                        textValign: MainAxisAlignment.center,
                        width: 89.w, textAlign: TextAlign.right,
                      ),
                      tableData(
                        data: [
                          '100.000.000',
                          '200.000.000'
                        ], // Data kolom kelima
                        bottom: true,
                        right: true,
                        textValign: MainAxisAlignment.center,
                        width: 89.w, textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
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
                                  onTap: () async {
                                    // getDefaultDialog().onFix(
                                    //     title: "Mohon Maaf",
                                    //     desc:
                                    //         "Fitur Pembayaran QRIS sedang dalam pengembangan",
                                    //     kategori: "error");
                                    print(controller.totalpajak);
                                    if (controller.totalpajak! > 10000000) {
                                      getDefaultDialog().onFix(
                                          title: "Mohon Maaf",
                                          desc:
                                              "Maksimal Pembayaran menggunakan QRIS adalah \nRp.10.000.000",
                                          kategori: "error");
                                    } else {
                                      Get.toNamed(Routes.QRISPBB, arguments: [
                                        controller.dataArgument.nopthn,
                                        controller.totalpajak,
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

class tableHead extends StatelessWidget {
  final String text;
  final bool top;
  final bool left;
  final bool bottom;
  final bool right;
  final double? width; // Lebar kolom opsional
  final TextAlign textAlign; // Parameter untuk pengaturan perataan teks

  const tableHead({
    Key? key,
    required this.text,
    this.top = false,
    this.left = false,
    this.bottom = false,
    this.right = false,
    this.width, // Parameter opsional
    this.textAlign = TextAlign.left, // Default perataan teks adalah kiri
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Gunakan lebar jika diberikan
      decoration: BoxDecoration(
        border: Border(
          top: top ? BorderSide(color: Colors.black) : BorderSide.none,
          left: left ? BorderSide(color: Colors.black) : BorderSide.none,
          bottom: bottom ? BorderSide(color: Colors.black) : BorderSide.none,
          right: right ? BorderSide(color: Colors.black) : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.sp, horizontal: 3.sp),
        child: Align(
          alignment: textAlign == TextAlign.right
              ? Alignment.centerRight
              : textAlign == TextAlign.center
                  ? Alignment.center
                  : Alignment.centerLeft, // Atur perataan teks
          child: Texts.textESPPT(text),
        ),
      ),
    );
  }
}

class tableData extends StatelessWidget {
  final List<String> data; // List data untuk kolom
  final bool top;
  final bool left;
  final bool bottom;
  final bool right;
  final double? width; // Lebar kolom opsional
  final TextAlign textAlign; // Parameter untuk pengaturan perataan teks
  final MainAxisAlignment textValign;

  const tableData({
    Key? key,
    required this.data,
    this.top = false,
    this.left = false,
    this.bottom = false,
    this.right = false,
    this.width, // Parameter opsional untuk lebar
    this.textAlign = TextAlign.left, // Default perataan teks adalah kiri
    this.textValign = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Gunakan lebar jika diberikan
      decoration: BoxDecoration(
        border: Border(
          top: top ? BorderSide(color: Colors.black) : BorderSide.none,
          left: left ? BorderSide(color: Colors.black) : BorderSide.none,
          bottom: bottom ? BorderSide(color: Colors.black) : BorderSide.none,
          right: right ? BorderSide(color: Colors.black) : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.sp, horizontal: 3.sp),
        child: Column(
          mainAxisAlignment: textValign,
          crossAxisAlignment: textAlign == TextAlign.right
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start, // Atur perataan teks
          children: data
              .map((item) => Texts.textESPPT(item, textAlign: textAlign))
              .toList(),
        ),
      ),
    );
  }
}
