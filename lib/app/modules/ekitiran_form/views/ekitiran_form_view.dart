import 'dart:io';

import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/ekitiran_form_controller.dart';

class EkitiranFormView extends GetView<EkitiranFormController> {
  const EkitiranFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Input Kitiran'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          dismissKeyboard();
        },
        child: SingleChildScrollView(
          child: GetBuilder<EkitiranFormController>(
            init: EkitiranFormController(),
            builder: (controller) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 245.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Texts.body2(
                                      "NOP (Masukkan Angka NOP Saja)",
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 164, 186, 206),
                                            blurRadius: 5,
                                            offset: Offset(-2, -2),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: controller.nop_cari,
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        inputFormatters: [
                                          controller.maskFormatter
                                        ], // Menggunakan maskFormatter
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.green),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.grey),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          hintText: '64.74.010.xxx.xxx.xxxx.0',
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Data harus diisi";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          if (controller.isReadySubmit) {
                                            controller.isReadySubmitToFalse();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Texts.body2(
                                    " ",
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 4.w, left: 5.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: gradientColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: Texts.caption("Cari NOP",
                                              isBold: true),
                                          onPressed: () {
                                            easyThrottle(
                                              handler: () {
                                                controller.fetchDataOffline();
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          //TextField atau widget lainnya di bawah
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 185,
                                child: TextFields.defaultTextField2(
                                  title: "NAMA",
                                  controller: controller.nama_wp,
                                  readOnly: true,
                                  isLoading: controller.isLoading,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.multiline,
                                  // prefixIcon: Icons.contact_emergency,
                                  borderColor: primaryColor,
                                  validator: true,
                                ),
                              ),
                              SizedBox(
                                width: 185,
                                child: TextFields.defaultTextField2(
                                  title: "KELURAHAN",
                                  controller: controller.kelurahan_wp,
                                  readOnly: true,
                                  isLoading: controller.isLoading,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.multiline,
                                  // prefixIcon: Icons.contact_emergency,
                                  borderColor: primaryColor,
                                  validator: true,
                                ),
                              ),
                            ],
                          ),
                          TextFields.defaultTextField2(
                            title: "ALAMAT PEMILIK",
                            controller: controller.alamat_wp,
                            readOnly: true,
                            isLoading: controller.isLoading,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.multiline,
                            // prefixIcon: Icons.contact_emergency,
                            borderColor: primaryColor,
                            validator: true,
                          ),
                          TextFields.defaultTextField2(
                            title: "ALAMAT OBJEK PAJAK",
                            controller: controller.alamat_op,
                            readOnly: true,
                            isLoading: controller.isLoading,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.multiline,
                            // prefixIcon: Icons.contact_emergency,
                            borderColor: primaryColor,
                            validator: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 185,
                                child: TextFields.defaultTextField2(
                                  title: "KECAMATAN OBJEK",
                                  controller: controller.kecamatan_op,
                                  readOnly: true,
                                  isLoading: controller.isLoading,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.multiline,
                                  // prefixIcon: Icons.contact_emergency,
                                  borderColor: primaryColor,
                                  validator: true,
                                ),
                              ),
                              SizedBox(
                                width: 185,
                                child: TextFields.defaultTextField2(
                                  title: "KELURAHAN OBJEK",
                                  controller: controller.kelurahan_op,
                                  readOnly: true,
                                  isLoading: controller.isLoading,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.multiline,
                                  // prefixIcon: Icons.contact_emergency,
                                  borderColor: primaryColor,
                                  validator: true,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                    child: Texts.body2(
                                        "Upload Foto Dokumentasi :")),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showChoiceDialog(context);
                                },
                                child: Container(
                                  child: (controller.imageFile == null)
                                      ? Image.asset(
                                          'assets/images/image.png',
                                          fit: BoxFit.contain,
                                        )
                                      : Image.file(
                                          fit: BoxFit.contain,
                                          File(controller.imageFile!.path)),
                                  width: 240.w,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9.w),
                                      border: Border.all(
                                          width: 1, color: MainColorGreen)),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              SizedBox(
                                width: 128.w,
                                height: 33.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.showChoiceDialog(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 64, 64, 64)),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.camera_alt, size: 20),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Pilih Gambar',
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              SizedBox(
                                width: 200.w,
                                child: Buttons.gradientButton(
                                  handler: () {
                                    easyThrottle(
                                      handler: () {
                                        controller.SimpanData();
                                      },
                                    );
                                  },
                                  widget: Texts.button("Simpan Data"),
                                  borderSide: false,
                                  gradient: [Colors.cyan, Colors.indigo],
                                ),
                              ),
                              SizedBox(height: 15.h),
                              // SizedBox(
                              //   width: 200.w,
                              //   child: Buttons.gradientButton(
                              //     handler: () {
                              //       controller.resetData();
                              //     },
                              //     widget: Texts.button("Reset Data"),
                              //     borderSide: false,
                              //     gradient: [Colors.cyan, Colors.indigo],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
