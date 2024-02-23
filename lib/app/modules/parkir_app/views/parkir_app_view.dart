import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/topline_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/parkir_app_controller.dart';

class ParkirAppView extends GetView<ParkirAppController> {
  const ParkirAppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Parkir App", leading: true, isLogin: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg-parkirapp.jpg'), // Path to your image asset
            opacity: 0.4,
            fit: BoxFit.cover, // Adjust this based on your requirements
          ),
        ),
        child: GetBuilder<ParkirAppController>(
          init: ParkirAppController(),
          builder: (controller) {
            return GestureDetector(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (int page) {
                  controller.currentPage = page;
                },
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          Texts.headline6("Pilih Jenis Kendaraan",
                              isBold: true),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 150.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 1),
                                        blurRadius: 2.0)
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () async {
                                      if (controller.modelConfigParkir.npwpd ==
                                          "") {
                                        EasyLoading.showInfo(
                                            "Konfigurasi belum di lakukan");
                                      } else {
                                        easyThrottle(
                                          handler: () {
                                            controller.PrintMotor();
                                          },
                                        );
                                      }
                                    },
                                    splashColor: Colors.amberAccent,
                                    splashFactory: InkSplash.splashFactory,
                                    child: Container(
                                      padding: EdgeInsets.all(2.0),
                                      child: Column(
                                        children: <Widget>[
                                          Transform.rotate(
                                            angle: 1.59,
                                            child: Image.asset(
                                              "assets/images/roda2.png",
                                              width: 150.w,
                                              height: 150.h,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Texts.caption("Motor",
                                              isBold: true,
                                              maxLines: 2,
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 1),
                                        blurRadius: 2.0)
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () {
                                      if (controller.modelConfigParkir.npwpd ==
                                          "") {
                                        EasyLoading.showInfo(
                                            "Konfigurasi belum di lakukan");
                                      } else {
                                        easyThrottle(
                                          handler: () {
                                            controller.PrintMobil();
                                          },
                                        );
                                      }
                                    },
                                    splashColor: Colors.blueAccent,
                                    splashFactory: InkSplash.splashFactory,
                                    child: Container(
                                      padding: EdgeInsets.all(2.0),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/images/roda4.png",
                                            width: 150.w,
                                            height: 150.h,
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Texts.caption("Mobil",
                                              isBold: true,
                                              maxLines: 2,
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Widget_historyparkir(controller: controller),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
          addBottomSheet(context: context);
        },
      ),
    );
  }

  addBottomSheet({required BuildContext context}) {
    Get.bottomSheet(GetBuilder<ParkirAppController>(
        init: ParkirAppController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              height: 350.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 16),
                child: Form(
                  //key: berita_C.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        topline_bottomsheet(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 164, 186, 206),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 12, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Pilih NPWPD Parkir',
                                    labelText: 'Pilih Npwpd Parkir *',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 0.0,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: lightGreenColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  items: controller.dropdown_npwpd.map((item) {
                                    return new DropdownMenuItem(
                                      child: Texts.captionSm(item['label']),
                                      value: item['value'].toString(),
                                    );
                                  }).toList(),
                                  onChanged: (newVal) {
                                    controller.updateValueDropdown("${newVal}");
                                  },
                                  value: controller.valuenpwpd == ""
                                      ? null
                                      : controller.valuenpwpd,
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                child: TextFormField(
                                  controller: controller.nama_usaha,
                                  enabled: controller.valuenpwpd == null
                                      ? false
                                      : true,
                                  style: TextStyle(fontSize: 12.sp),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 12, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Masukkan Nama Usaha',
                                    labelText: 'Nama Usaha *',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                              SizedBox(height: 15),
                              Container(
                                child: TextFormField(
                                  controller: controller.alamat_usaha,
                                  enabled: controller.valuenpwpd == null
                                      ? false
                                      : true,
                                  style: TextStyle(fontSize: 12.sp),
                                  minLines:
                                      2, // any number you need (It works as the rows for the textarea)
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 12, 0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'Masukkan Alamat Usaha',
                                    labelText: 'Alamat/Lokasi Usaha *',
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.0),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGreenColor, width: 2),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Container(
                                    width: 149.w,
                                    child: TextFormField(
                                      controller: controller.harga_roda2,
                                      enabled: controller.valuenpwpd == null
                                          ? false
                                          : true,
                                      style: TextStyle(fontSize: 12.sp),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 12, 12, 0),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Masukkan Harga Roda 2',
                                        labelText: 'Harga Roda 2 *',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGreenColor, width: 2),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .digitsOnly // Allow only digits
                                      ],
                                      onChanged: (string) {
                                        controller.onChangedRp2(string);
                                      },
                                    ),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 164, 186, 206),
                                        blurRadius: 5,
                                      ),
                                    ]),
                                  ),
                                  SizedBox(width: 5.w),
                                  Container(
                                    width: 149.w,
                                    child: TextFormField(
                                      controller: controller.harga_roda4,
                                      enabled: controller.valuenpwpd == null
                                          ? false
                                          : true,
                                      style: TextStyle(fontSize: 12.sp),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(12, 12, 12, 0),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Masukkan Harga Roda 4',
                                        labelText: 'Harga Roda 4 *',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGreenColor, width: 2),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .digitsOnly // Allow only digits
                                      ],
                                      onChanged: (string) {
                                        controller.onChangedRp4(string);
                                      },
                                    ),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 164, 186, 206),
                                        blurRadius: 5,
                                      ),
                                    ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 120.w,
                              child: OutlinedButton.icon(
                                  //Handle button press event
                                  onPressed: () {
                                    easyThrottle(
                                      handler: () {
                                        controller.simpanConfig();
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
                                  icon: const Icon(Icons.save_alt),
                                  label: const Text("Simpan")),
                            ),
                            SizedBox(
                              width: 120.w,
                              child: OutlinedButton.icon(
                                  //Handle button press event
                                  onPressed: () {
                                    Get.back();
                                    //berita_C.hapusisi();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      color: lightRedColor,
                                      width: 1,
                                    ),
                                    onPrimary: lightRedColor,
                                  ),
                                  icon: const Icon(Icons.cached_rounded),
                                  label: const Text("Batal")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}

class Widget_historyparkir extends StatelessWidget {
  final ParkirAppController controller;
  const Widget_historyparkir({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParkirAppController>(
      init: ParkirAppController(),
      builder: (controller) {
        if (controller.isEmpty) {
          return NoData(); //menampilkan lotties no data
        }

        if (controller.isLoading) {
          return ShimmerWidget.Items1();
        }
        return ListView.builder(
            itemCount: controller.datalist.length + 1,
            controller: controller.controllerScroll,
            itemBuilder: (context, index) {
              if (index < controller.datalist.length) {
                var dataitem = controller.datalist[index];
                Color backgroundColor = index.isEven
                    ? Color.fromARGB(255, 234, 246, 255)
                    : Colors.white;
                return Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 110.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Texts.captionSm(
                              maxLines: 1,
                              "${dataitem.npwpd}",
                              color: Color.fromARGB(255, 59, 59, 59),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 55.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Texts.captionSm(
                              "${dataitem.jenis}",
                              color: Color.fromARGB(255, 59, 59, 59),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Texts.captionSm(
                              "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(dataitem.nominal))}",
                              color: Color.fromARGB(255, 59, 59, 59),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 130.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Texts.captionSm(
                              "${DateFormat('yyyy-MM-dd HH:mm:ss').format(dataitem.date)}",
                              color: Color.fromARGB(255, 59, 59, 59),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: controller.hasMore
                        ? CircularProgressIndicator()
                        : Text("Tidak ada data lagi"),
                  ),
                );
              }
            });
      },
    );
  }
}
