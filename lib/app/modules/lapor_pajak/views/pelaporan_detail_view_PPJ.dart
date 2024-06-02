import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/views/histori_pajak.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/views/histori_pajak2.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/views/histori_pajak3.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/views/histori_pajak4.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/views/histori_pajak5.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';

import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/pelaporan_detail_controller.dart';

class PelaporanDetailViewPPJ extends GetView<PelaporanDetailController> {
  PelaporanDetailViewPPJ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Tab> Tabs = <Tab>[
      //5 tahun terakhir
      Tab(text: "${controller.tahunhistory[0]}"),
      Tab(text: "${controller.tahunhistory[1]}"),
      Tab(text: "${controller.tahunhistory[2]}"),
      Tab(text: "${controller.tahunhistory[3]}"),
      Tab(text: "${controller.tahunhistory[4]}"),
    ];
    return Scaffold(
        appBar: CustomAppBar(
          title: "Pelaporan Pajak ${controller.jenispajak}",
          leading: true,
          isLogin: true,
        ),
        body: GestureDetector(
          onTap: () {
            dismissKeyboard();
          },
          child: GetBuilder<PelaporanDetailController>(
            init: PelaporanDetailController(
              Get.find<Api>(),
            ),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 85.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/listview.png"),
                                    fit: BoxFit.fill),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(8, 6),
                                      color: lightGreenColor.withOpacity(0.3)),
                                  BoxShadow(
                                      blurRadius: 10,
                                      offset: Offset(5, 100),
                                      color: lightGreenColor.withOpacity(0.3))
                                ]),
                          ),
                          Container(
                            width: double.maxFinite,
                            height: 90.h,
                            margin: EdgeInsets.only(
                                left: 130.sp, top: 8.sp, right: 17.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "${controller.dataArgument.npwpd}",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MainColor),
                                ),
                                Text(
                                  "${controller.dataArgument.namaUsaha}",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MainColor),
                                ),
                                Text(
                                  "${controller.dataArgument.alamatUsaha}",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold,
                                      color: lightTextColor),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Transform.scale(
                                    scale: 1.2,
                                    child: Transform.translate(
                                        offset: Offset(5.sp, -45.sp),
                                        child: controller.dataArgument.status ==
                                                "0"
                                            ? Icon(Icons.warning_amber,
                                                color: Colors.amber)
                                            : Icon(
                                                Icons
                                                    .check_circle_outline_outlined,
                                                color: Colors.green)),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.dataArgument.status == "0"
                        ? Center(
                            child: Column(
                            children: [
                              Lottie.asset(
                                'assets/lottie/ditinjau.json',
                                width: 38.w,
                                height: 38.h,
                              ),
                              Text(
                                "Data Wajib Pajak sedang ditinjau Petugas \n Mohon Menunggu ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: lightBlueColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                        : controller.dataArgument.status == "3"
                            ? Center(
                                child: Column(
                                children: [
                                  Lottie.asset(
                                    'assets/lottie/ditinjau.json',
                                    width: 38.w,
                                    height: 38.h,
                                  ),
                                  Text(
                                    "Data Wajib Pajak sedang ditinjau Petugas \n Mohon Menunggu ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: lightBlueColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ))
                            : Container(
                                decoration: BoxDecoration(
                                  gradient:
                                      LinearGradient(colors: gradientColor),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(height: 5),
                                    Texts.headline6(
                                        "Pelaporan Pajak ${controller.jenispajak}",
                                        isBold: true,
                                        color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Texts.caption("Masa Pajak",
                                                isBold: true,
                                                color: Colors.white),
                                          ),
                                          Stack(
                                            children: [
                                              TextFormField(
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          10, 30, 10, 0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: '',
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
                                                onTap: () {
                                                  controller
                                                      .month_picker(context);
                                                },
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  child: Text(
                                                    controller.FinalDate == null
                                                        ? ""
                                                        : "${controller.FinalDate}",
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      left: 10, top: 13),
                                                ),
                                                onTap: () {
                                                  showMonthPicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                  ).then((date) {
                                                    if (date != null) {
                                                      controller.selectedDate =
                                                          date;
                                                      var ubahyear =
                                                          "Tahun: ${controller.selectedDate!.year} Bulan: ${controller.selectedDate!.month}";
                                                      controller.FinalDate =
                                                          ubahyear.toString();
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: Texts.caption(
                                                        "Omset Kotor / Bruto",
                                                        isBold: true,
                                                        color: Colors.white),
                                                  ),
                                                  Container(
                                                    child: TextFormField(
                                                      controller:
                                                          controller.pendapatan,
                                                      decoration:
                                                          InputDecoration(
                                                        errorStyle: TextStyle(
                                                            height: 0),
                                                        prefixIcon: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 12,
                                                                  left: 8),
                                                          child: Texts.caption(
                                                            "Rp.",
                                                          ),
                                                        ),
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 30, 10, 0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText: '',
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.0),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreenColor,
                                                              width: 2),
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                      ],
                                                      onChanged: (string) {
                                                        controller.onChangedRp(
                                                            string);
                                                      },
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    164,
                                                                    186,
                                                                    206),
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(-2, -2),
                                                          ),
                                                        ]),
                                                  ),
                                                ],
                                              )),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: Texts.caption("KWH",
                                                        isBold: true,
                                                        color: Colors.white),
                                                  ),
                                                  Container(
                                                    child: TextFormField(
                                                      controller:
                                                          controller.kwh,
                                                      decoration:
                                                          InputDecoration(
                                                        errorStyle: TextStyle(
                                                            height: 0),
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 30, 10, 0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText: '',
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.0),
                                                        ),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  lightGreenColor,
                                                              width: 2),
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9,]')),
                                                      ],
                                                      onChanged: (string) {
                                                        controller
                                                            .onChangedRpKWH(
                                                                string);
                                                      },
                                                    ),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    164,
                                                                    186,
                                                                    206),
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(-2, -2),
                                                          ),
                                                        ]),
                                                  ),
                                                ],
                                              ))
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Texts.caption(
                                                    "Upload LHP/Bukti Pembukuan : ",
                                                    isBold: true,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Buttons.defaultButtonMed(
                                                      fillColor: Color.fromARGB(
                                                          255, 245, 85, 88),
                                                      handler: () {
                                                        dismissKeyboard();
                                                        controller
                                                            .showChoiceDialog(
                                                                context);
                                                      },
                                                      title: "Pilih File"),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  (controller.imageFile == null)
                                                      ? Text("")
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                            color: Colors.white,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.check_box,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        108,
                                                                        226,
                                                                        112),
                                                                size: 20.sp,
                                                              ),
                                                              Text(
                                                                  "Berhasil Upload File",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13.sp,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          124,
                                                                          224,
                                                                          127),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))
                                                            ],
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              Text(
                                                  "File yang diupload harus Gambar/PDF/Word/Excel",
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.white)),
                                              SizedBox(height: 10),
                                            ],
                                          ),
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
                            child: Text("Simpan"),
                            onPressed: () {
                              easyThrottle(
                                handler: () {
                                  controller.simpanLaporanPPJ();
                                },
                              );
                            }),
                      ),
                    ),
                    //Text("${controller.dataArgument.idWajibPajak}"),
                    DefaultTabController(
                      length: 5, // Number of tabs
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: lightBlueColor,
                            unselectedLabelColor: MainColor,
                            indicatorColor: lightBlueColor,
                            //isScrollable: true,
                            tabs: Tabs,
                          ),
                          SizedBox(
                            height: (Get.height * 0.136) *
                                12, // Adjust the height as needed
                            child: TabBarView(
                              children: [
                                HistoryPajak(
                                    id_wajib_pajak:
                                        controller.dataArgument.idWajibPajak),
                                HistoryPajak2(
                                    id_wajib_pajak:
                                        controller.dataArgument.idWajibPajak),
                                HistoryPajak3(
                                    id_wajib_pajak:
                                        controller.dataArgument.idWajibPajak),
                                HistoryPajak4(
                                    id_wajib_pajak:
                                        controller.dataArgument.idWajibPajak),
                                HistoryPajak5(
                                    id_wajib_pajak:
                                        controller.dataArgument.idWajibPajak),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
