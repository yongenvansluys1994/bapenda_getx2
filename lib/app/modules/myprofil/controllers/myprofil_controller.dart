import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/myprofil/models/model_ads.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MyprofilController extends GetxController {
  Api api;
  MyprofilController(this.api);
  final dashboardController = Get.find<DashboardController>();
  late AuthModel authModel;
  XFile? imageFile = null;
  TextEditingController nama_usaha = TextEditingController();
  TextEditingController judul_promosi = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  RxList<ModelAds> datalist = <ModelAds>[].obs;

  final Uri _url =
      Uri.parse('http://yongen-bisa.com/bapenda_app/request_delete.php');
  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchAds();
    update();
  }

  Future<void> FetchlaunchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> fetchAds() async {
    try {
      isLoading = true;
      update();

      final datauser = await api.getAds(authModel.nik);

      print(jsonEncode(datauser));
      if (datauser == null) {
        isFailed = true;
        isLoading = false;
        update();
      } else if (datauser.isEmpty) {
        isEmpty = true;
        isLoading = false;
        update();
      } else {
        isLoading = false;
        datalist.addAll(datauser);
        isEmpty = false;
        update();
      }

      isLoading = false;
      update();
    } on DioError catch (ex) {
      var errorMessage = "";
      if (ex.type == DioErrorType.connectionTimeout ||
          ex.type == DioErrorType.connectionError ||
          ex.type == DioErrorType.receiveTimeout ||
          ex.type == DioErrorType.sendTimeout) {
        errorMessage = "Limit Connection, Koneksi anda bermasalah";
      } else {
        errorMessage = "$ex";
      }
      RawSnackbar_top(message: "$errorMessage", kategori: "error", duration: 4);
      update();
    }
  }

  void openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedFile!;
    update();
    print(imageFile);
  }

  void simpanData() {
    if (nama_usaha.text == "" ||
        judul_promosi.text == "" ||
        deskripsi.text == "") {
      RawSnackbar_bottom(
          message: "Seluruh Form wajib di isi, Periksa kembali",
          kategori: "error",
          duration: 2);
    } else if (imageFile == null) {
      RawSnackbar_bottom(
          message: "Upload Gambar Tidak Boleh Kosong!",
          kategori: "error",
          duration: 2);
    } else {
      uploadPromosi();
      update();
    }
    update();
  }

  Future uploadPromosi() async {
    //Awal Loading Disini-------------------------------
    var request =
        http.MultipartRequest("POST", Uri.parse("${URL_APP}/ads/upload.php"));
    request.fields['nama_usaha'] = nama_usaha.text;
    request.fields['judul_promosi'] = judul_promosi.text;
    request.fields['deskripsi'] = deskripsi.text;
    request.fields['nik'] = authModel.nik!;

    var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      RawSnackbar_top(
          message: "Berhasil Input Data", kategori: "success", duration: 2);
      datalist.clear();
      fetchAds();
      update();
      nama_usaha.clear();
      judul_promosi.clear();
      deskripsi.clear();
      imageFile = null;
    } else {
      RawSnackbar_top(message: "Gagal Upload ", kategori: "error", duration: 2);
    }
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
}
