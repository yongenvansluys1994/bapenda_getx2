import 'dart:async';
import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/topline_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EkitiranController extends GetxController {
  late AuthModel authModel;

  bool isLoadingSuggest = false;
  final TextEditingController userrt_kecamatan = TextEditingController();
  final TextEditingController userrt_kelurahan = TextEditingController();
  final TextEditingController userrt_rt = TextEditingController();

  final TextEditingController nama_cari = TextEditingController();
  final TextEditingController nop_cari = TextEditingController();
  final TextEditingController nama_wp = TextEditingController();
  final TextEditingController nop_wp = TextEditingController();
  final TextEditingController alamat_wp = TextEditingController();
  final TextEditingController kelurahan_wp = TextEditingController();
  final TextEditingController alamat_op = TextEditingController();

  Timer? debounce;
  List<Map<String, String>> suggestions = [];
  final String apiUrl =
      "https://yongen-bisa.com/bapenda_app/api_ver2/admin/suggest_nama.php";

  final List<String> kecamatanList = [
    'Bontang Utara',
    'Bontang Selatan',
    'Bontang Barat',
  ];
  List<String> availableKelurahan =
      []; // Kelurahan yang tersedia berdasarkan Kecamatan
  final Map<String, List<String>> kelurahanByKecamatan = {
    'Bontang Barat': [
      'Belimbing',
      'Kanaan',
      'Telihan',
    ],
    'Bontang Selatan': [
      'Berbas Pantai',
      'Berbas Tengah',
      'Bontang Lestari',
      'Satimpo',
      'Tanjung Laut',
      'Tanjung Laut Indah',
    ],
    'Bontang Utara': [
      'Api-Api',
      'Bontang Baru',
      'Bontang Kuala',
      'Guntung',
      'Gunung Elai',
      'Lok Tuan',
    ],
  };

  @override
  void onInit() {
    super.onInit();
    availableKelurahan = []; // Awalnya kosong
    authModel = Get.arguments;

    checkUserRt(authModel.idUserwp);
  }

  // Fetch suggestions dari API
  Future<void> fetchSuggestions(String query) async {
    isLoadingSuggest = true;
    if (query.isEmpty) {
      suggestions = [];
      isLoadingSuggest = false;
      update(); // Perbarui UI
      return;
    }

    try {
      final response = await http.get(Uri.parse('$apiUrl?query=$query'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Map respons ke bentuk yang diinginkan
        suggestions = data
            .map((item) => {
                  'nama_usaha': item['nama_usaha'].toString(),
                  'npwpd': item['npwpd'].toString(),
                  'alamat_usaha': item['alamat_usaha'].toString(),
                })
            .toList();
        isLoadingSuggest = false;
        print("Suggestions: $suggestions");
      }
    } catch (e) {
      isLoadingSuggest = false;
      print("Error fetching suggestions: $e");
    }
    isLoadingSuggest = false;
    update(); // Perbarui UI
  }

  void onTextChanged(String query) {
    // Cancel debounce timer jika masih berjalan
    if (debounce?.isActive ?? false) debounce?.cancel();

    // Set delay 1 detik sebelum fetch
    debounce = Timer(Duration(milliseconds: 500), () {
      fetchSuggestions(query);
    });
  }

  void removeSuggestList() {
    suggestions.clear();
    update();
  }

  void SimpanData() {
    getDefaultDialog().onConfirm(
      title: "Anda yakin telah Mengisi Data dengan Benar?",
      desc: "Pastikan data yang anda isi telah sesuai",
      kategori: "warning",
      handler: () {
        Get.back();
        ProsesData();
        update();
      },
    );
  }

  void ProsesData() async {
    EasyLoading.show();
    // API disini
    var url = Uri.parse("${URL_APPSIMPATDA}/ekitiran/user_rt_input.php");
    var response = await http.post(url, body: {
      "id_userwp": "${authModel.idUserwp}",
      "kecamatan": "${userrt_kecamatan.text}",
      "kelurahan": "${userrt_kelurahan.text}",
      "rt": "${userrt_rt.text}",
    });

    var data = json.decode(response.body);

    if (data['success'] != null) {
      Get.back();
      RawSnackbar_bottom(
        message: "${data['success']}",
        kategori: "success",
        duration: 3,
      );

      update();
    } else {
      RawSnackbar_top(
        message: "Gagal, terjadi gangguin di jaringan.",
        kategori: "Error",
        duration: 3,
      );
      update();
    }
    EasyLoading.dismiss();
    update();
  }

  void checkUserRt(idUserwp) async {
    var url = Uri.parse("${URL_APPSIMPATDA}/ekitiran/cek_user_rt.php");
    var response = await http.post(url, body: {
      "id_userwp": "${authModel.idUserwp}",
    });

    var data = json.decode(response.body);

    if (data['status'] == 'non_exists') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showBottomSheet();
      });
      update();
    }
  }

  void changeValue_userrt_kecamatan(String? newValue) {
    userrt_kecamatan.text = newValue!;
    availableKelurahan = kelurahanByKecamatan[newValue] ?? [];
    userrt_kelurahan.text = "";
    userrt_rt.text = "";
    update();
  }

  void changeValue_userrt_kelurahan(String? newValue) {
    userrt_kelurahan.text = newValue!;
    update();
  }

  void changeValue_userrt_rt(String? newValue) {
    userrt_rt.text = newValue!;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topline_bottomsheet(),
              SizedBox(height: 20),
              GetBuilder<EkitiranController>(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Texts.caption(
                                        "Pilih Kecamatan",
                                      ),
                                      InputDecorator(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            borderSide: BorderSide(
                                                width: 1.0, color: Colors.grey),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 2.h, horizontal: 10.h),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: MainColorGreen),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                                width: 1.0, color: Colors.blue),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: controller.userrt_kecamatan
                                                    .text.isEmpty
                                                ? null
                                                : controller
                                                    .userrt_kecamatan.text,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Texts.caption(
                                        "Pilih Kecamatan",
                                      ),
                                      InputDecorator(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            borderSide: BorderSide(
                                                width: 1.0, color: Colors.grey),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 2.h, horizontal: 10.h),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: MainColorGreen),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                                width: 1.0, color: Colors.blue),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: controller.userrt_kelurahan
                                                    .text.isEmpty
                                                ? null
                                                : controller
                                                    .userrt_kelurahan.text,
                                            hint: const Text("Pilih Kelurahan"),
                                            isExpanded: true,
                                            onChanged: controller
                                                    .availableKelurahan
                                                    .isNotEmpty
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
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
      isDismissible: false,
    );
  }
}
