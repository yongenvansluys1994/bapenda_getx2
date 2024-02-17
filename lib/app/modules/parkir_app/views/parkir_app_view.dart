import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/topline_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/parkir_app_controller.dart';

class ParkirAppView extends GetView<ParkirAppController> {
  const ParkirAppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Parkir App", leading: true, isLogin: true),
      body: GetBuilder<ParkirAppController>(
        init: ParkirAppController(),
        builder: (controller) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Texts.headline6("Pilih Jenis Kendaraan", isBold: true),
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
                              easyThrottle(
                                handler: () {
                                  controller.PrintMotor();
                                },
                              );
                            },
                            splashColor: Colors.amberAccent,
                            splashFactory: InkSplash.splashFactory,
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/roda2.png",
                                    width: 150.w,
                                    height: 150.h,
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
                              easyThrottle(
                                handler: () {
                                  controller.PrintMobil();
                                },
                              );
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
          );
        },
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
    Get.bottomSheet(
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: 300.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
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
                          SizedBox(height: 15),
                          Container(
                            child: TextFormField(
                              controller: controller.nama_usaha,
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
                              //focusNode: berita_C.focusNode,
                              minLines:
                                  3, // any number you need (It works as the rows for the textarea)
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
                                width: 150.w,
                                child: TextFormField(
                                  controller: controller.harga_roda2,
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
                                    color: Color.fromARGB(255, 164, 186, 206),
                                    blurRadius: 5,
                                  ),
                                ]),
                              ),
                              SizedBox(width: 5.w),
                              Container(
                                width: 150.w,
                                child: TextFormField(
                                  controller: controller.harga_roda4,
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
                                    color: Color.fromARGB(255, 164, 186, 206),
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
                                controller.simpanConfig();
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
      ),
    );
  }
}
