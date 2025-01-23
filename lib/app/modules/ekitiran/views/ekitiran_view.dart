import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/ekitiran_controller.dart';

class EkitiranView extends GetView<EkitiranController> {
  const EkitiranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "E-Kitiran PBB RT",
          leading: true,
          isLogin: true,
        ),
        body: GetBuilder<EkitiranController>(
            init: EkitiranController(),
            builder: (controller) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texts.body1(
                          'Selamat Datang di Aplikasi E-Kitiran PBB RT, Lengkapi terlebih dahulu data RT anda dibawah ini untuk Lanjut.',
                          isBold: true,
                          maxLines: 3,
                          textAlign: TextAlign.center),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Container(
                            width: 167.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.caption(
                                  "Pilih Kecamatan",
                                ),
                                InputDecorator(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 10.h),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 1.0, color: MainColorGreen),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 1.0, color: Colors.blue),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller
                                              .userrt_kecamatan.text.isEmpty
                                          ? null
                                          : controller.userrt_kecamatan.text,
                                      hint: const Text("Pilih Kecamatan"),
                                      isExpanded: true,
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          controller
                                              .changeValue_userrt_kecamatan(
                                                  newValue);
                                        }
                                      },
                                      items: controller.kecamatanList
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5.h),
                          Container(
                            width: 167.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts.caption(
                                  "Pilih Kecamatan",
                                ),
                                InputDecorator(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                      borderSide: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 10.h),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 1.0, color: MainColorGreen),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 1.0, color: Colors.blue),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: controller
                                              .userrt_kelurahan.text.isEmpty
                                          ? null
                                          : controller.userrt_kelurahan.text,
                                      hint: const Text("Pilih Kelurahan"),
                                      isExpanded: true,
                                      onChanged: controller
                                              .availableKelurahan.isNotEmpty
                                          ? (newValue) {
                                              if (newValue != null) {
                                                controller
                                                    .changeValue_userrt_kelurahan(
                                                        newValue);
                                              }
                                            }
                                          : null, // Disable dropdown if no kelurahan available
                                      items: controller.availableKelurahan
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: 100.w,
                        child: TextFields.textFieldDropdown(
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          isLoading: false,
                          controller: controller.userrt_rt,
                          hintText: "Pilih RT",
                          title: "Pilih RT",
                          isDropdown: true,
                          dropdownItems: [
                            '01',
                            '02',
                            '03',
                            '04',
                            '05',
                            '06',
                            '07',
                            '08',
                            '09',
                            '10',
                            '11',
                            '12',
                            '13',
                            '14',
                            '15',
                            '16',
                            '17',
                            '18',
                            '19',
                            '20',
                            '21',
                            '22',
                            '23',
                            '24',
                            '25',
                            '26',
                            '27',
                            '28',
                            '29',
                            '30',
                            '31',
                            '32',
                            '33',
                            '34',
                            '35',
                            '36',
                            '37',
                            '38',
                            '39',
                            '40',
                            '41',
                            '42',
                            '43',
                            '44',
                            '45',
                            '46',
                            '47',
                            '48',
                            '49',
                            '50',
                            '51',
                            '52',
                            '53',
                            '54',
                            '55'
                          ],
                          dropdownValue: controller.userrt_rt.text.isEmpty
                              ? null
                              : controller.userrt_rt.text,
                          onDropdownChanged: (newValue) {
                            controller.changeValue_userrt_rt(newValue);
                          },
                          validator: true,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Buttons.gradientButton(
                        handler: () {
                          controller.SimpanData();
                        },
                        widget: Texts.body1(
                          "Simpan",
                        ),
                        gradient: [Colors.cyan, Colors.indigo],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
