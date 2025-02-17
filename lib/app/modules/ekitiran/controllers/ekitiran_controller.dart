import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/ekitiran/models/kitiran_model.dart';
import 'package:bapenda_getx2/app/modules/ekitiran/models/rt_model.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/topline_bottomsheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class EkitiranController extends GetxController {
  late RTModel rtModel;

  //progress sync untuk loading progress sat sinkronisasi data offline ke online
  var progressSync = 0.0.obs;

  final storage = GetStorage();

  RxList<ModelKitiran> datalist = <ModelKitiran>[].obs;
  bool hasMore = true;
  int page = 1;
  final controllerScroll = ScrollController();
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;

  bool isLoadingSuggest = false;
  final TextEditingController id_user_rt = TextEditingController();
  final TextEditingController nama = TextEditingController();
  final TextEditingController userrt_kecamatan = TextEditingController();
  final TextEditingController userrt_kelurahan = TextEditingController();
  final TextEditingController userrt_rt = TextEditingController();

  //controller untuk cetak laporan
  final TextEditingController tahun_cetak = TextEditingController();

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
  void onInit() async {
    super.onInit();
    availableKelurahan = []; // Awalnya kosong

    // Cek koneksi internet
    bool isConnected = await isInternetConnected();

    if (isConnected) {
      checkAndDownloadPBBData();

      logInfo("ada internet");
      // Jika ada internet, jalankan logika untuk memeriksa RT user
      if (storage.hasData('user_rt')) {
        logInfo("ada Akun RT di Storage");
        rtModel = RTModel.fromJson(storage.read('user_rt'));
        logInfo("Akun RT di storage user_rt: ${jsonEncode(rtModel)}");
        if (rtModel.isSynced == false) {
          logInfo("Sync Akun RT ke Online");
          // jika data di user_rt masih false berarti blm di sync ke online
          await syncUserRT(rtModel); // Sinkronkan ke database online
        }
        // Jika ada internet, periksa apakah getx storage kitiran_pbb kosong
        if (!storage.hasData('kitiran_pbb')) {
          logInfo("kitiran_pbb kosong, melakukan fetch dari API");
          await FetchKitiranThenSync(
              rtModel.kelurahan, rtModel.rt); // Fetch dari API
        } else {
          logInfo("kitiran_pbb ada isinya, melakukan sync lalu fetch data");
          checkSyncStatus();
        }
      } else {
        logInfo("Belum punya akun RT");
        // Tampilkan error menggunakan RawSnackbar jika data tidak ada
        showBottomSheet(flag: "baru");
      }

      // Tambahkan listener untuk scroll
      controllerScroll.addListener(() {
        if (controllerScroll.position.maxScrollExtent ==
            controllerScroll.offset) {
          FetchKitiran(rtModel.kelurahan, rtModel.rt);
          update();
        }
      });
    } else {
      // Jika tidak ada koneksi internet, cek apakah ada data di GetStorage
      if (storage.hasData('user_rt')) {
        logInfo("Offline tapi ada akun RT di Storage");
        // Isi rtModel dengan data dari GetStorage
        rtModel = RTModel.fromJson(storage.read('user_rt'));
        FetchKitiranOffline();
      } else {
        logInfo("Belum punya akun RT");
        // Tampilkan error menggunakan RawSnackbar jika data tidak ada
        showBottomSheet(flag: "baru");
      }
    }
  }

  Future<void> checkSyncStatus() async {
    // Mendapatkan tanggal hari ini dalam format yyyy-MM-dd
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Cek apakah ada data sinkronisasi sebelumnya
    String? lastSyncDate = storage.read('already_sync_ekitiran');

    // Jika tanggal sinkronisasi sebelumnya berbeda dengan hari ini
    if (lastSyncDate != today) {
      backupKitiranPbb();
      // Ambil semua data dari GetX Storage
      List<ModelKitiran> kitiranList =
          (GetStorage().read<List<dynamic>>('kitiran_pbb') ?? [])
              .map((e) => ModelKitiran.fromJson(e))
              .toList();

      // Filter data yang belum tersinkronisasi
      List<ModelKitiran> unsyncedData =
          kitiranList.where((item) => !item.isSynced).toList();

      // Jika ada data yang belum tersinkronisasi, jalankan sync
      if (unsyncedData.isNotEmpty) {
        logInfo("Sinkronisasi data dengan sismiop");
        syncAndFetchKitiran();
      } else {
        await FetchKitiranThenSync(
            rtModel.kelurahan, rtModel.rt); // Fetch dari API
      }
      storage.write('already_sync_ekitiran', today);
      logInfo("save flag already_sync_ekitiran");
    } else {
      // Jika sudah sinkronisasi hari ini
      logInfo(
          "Data sudah disinkronkan hari ini, tidak bisa sinkronisasi ulang.");
      syncAndFetchKitiran();
    }
  }

  Future<void> syncAndFetchKitiran() async {
    try {
      // Ambil semua data dari GetX Storage kitiran_pbb
      List<ModelKitiran> kitiranList =
          (GetStorage().read<List<dynamic>>('kitiran_pbb') ?? [])
              .map((e) => ModelKitiran.fromJson(e))
              .toList();
      logInfo(jsonEncode(kitiranList));
      // Filter data yang belum tersinkronisasi/isSynced is False
      List<ModelKitiran> unsyncedData =
          kitiranList.where((item) => !item.isSynced).toList();

      if (unsyncedData.isEmpty || kitiranList.isEmpty) {
        logInfo("Tidak ada data baru untuk disinkronisasi.");
        FetchKitiran(rtModel.kelurahan, rtModel.rt);
        return; // Tidak ada data yang perlu disinkronisasi
      }

      // Buat daftar untuk menampung data hasil sinkronisasi dari server
      List<ModelKitiran> syncedData = [];

      //jalankan loading progress sesuai jumlah row Kitiran
      showSyncProgressDialog();

      final int totalData = unsyncedData.length;
      for (int i = 0; i < totalData; i++) {
        var item = unsyncedData[i];

        // Membuat request multipart untuk setiap item
        var request = http.MultipartRequest(
            "POST", Uri.parse("${URL_APP}/ekitiran/kitiran_sync.php"));

        request.fields['kelurahan'] = item.kelurahan!;
        request.fields['rt'] = item.rt!;
        request.fields['nop'] = item.nop;
        request.fields['nama'] = item.nama;
        request.fields['alamat'] = item.alamat;
        request.fields['kecamatan_op'] = '${item.kecamatanOp}';
        request.fields['kelurahan_op'] = '${item.kelurahanOp}';
        request.fields['alamat_op'] = '${item.alamatOp}';
        request.fields['tahun'] = item.tahun;
        request.fields['jumlah_pajak'] = item.jumlahPajak;
        request.fields['status_pembayaran_sppt'] = item.statusPembayaranSppt;
        request.fields['keterangan'] = item.keterangan;
        request.fields['tgl_bayar'] = item.tglBayar.toIso8601String();

        // Tambahkan file bukti jika ada
        if (item.bukti.isNotEmpty) {
          logInfo("Proses Upload Bukti Kitiran ke Server");
          var file = File(item.bukti);

          if (await file.exists()) {
            var pic = await http.MultipartFile.fromPath("image", item.bukti);
            request.files.add(pic);
          } else {
            // Ambil nama file dari item.bukti
            String fileName = path.basename(item.bukti);

            // Gunakan nama file yang sama meskipun file tidak ditemukan
            var dummyFile = http.MultipartFile.fromString(
              "image",
              "",
              filename: fileName,
            );
            request.files.add(dummyFile);
          }
        }

        // Kirim request
        var response = await request.send();

        // Baca dan decode response
        var responseBody = await response.stream.bytesToString();

        //logInfo("${responseBody}");
        // logInfo(json.decode(responseBody));
        var data = json.decode(responseBody);

        if (response.statusCode == 200 && data['success'] != null) {
          //hapus cache image
          final fileName = path.basename(item.bukti);
          clearImagePickerCache(fileName);
          print(
              "Data dengan NOP ${item.nop} berhasil disinkronisasi. ${data['data']}");
          logInfo(jsonEncode(data['data']));

          // Tambahkan data yang berhasil disinkronisasi ke daftar hasil sinkronisasi
          if (data['data'] != null && data['data'] is List) {
            List<dynamic> serverData = data['data'];
            //logInfo(jsonEncode(serverData));
            for (var serverItem in serverData) {
              ModelKitiran model = ModelKitiran.fromJson(serverItem);

              // Cek apakah data sudah ada di syncedData untuk menghindari duplikasi
              if (!syncedData.any((e) => e.nop == model.nop)) {
                syncedData.add(model);
              }
            }
          }
        } else {
          print(
              "Gagal menyinkronkan data dengan NOP ${item.nop}. ${responseBody}");
        }

        // **Update Progress** setelah setiap item berhasil diproses
        progressSync.value = ((i + 1) / totalData);
        update();
      }
      Get.back();

      // Gabungkan data yang tersinkronisasi dengan data lama tanpa duplikasi
      List<ModelKitiran> updatedList = syncedData.toList();
      for (var oldItem in kitiranList) {
        if (!updatedList.any((e) => e.nop == oldItem.nop)) {
          updatedList.add(oldItem);
        }
      }

      // Simpan data terbaru ke GetX Storage
      GetStorage().write(
        'kitiran_pbb',
        updatedList.map((e) => e.toJson()).toList(),
      );
      FetchKitiranOffline(); // fetch ulang Ekitiran dari getx Storage
      update();

      print("Data berhasil diperbarui di GetX Storage.");
    } catch (e) {
      Get.defaultDialog(content: Text("$e"));
    }
  }

  Future FetchKitiran(kelurahan, rt) async {
    EasyLoading.show(
        status: "Sedang Memuat Data Kitiran",
        maskType: EasyLoadingMaskType.clear);
    datalist.clear();

    if (isLoading) return;

    const limit = 18;
    final url = Uri.parse(
        '${URL_APP}/ekitiran/kitiran_list.php?kelurahan=$kelurahan&rt=$rt&tahun=$tahun_pbb');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List newItems =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        final list =
            newItems.map<ModelKitiran>((json) => ModelKitiran.fromJson(json));
        page++;
        isLoading = false;

        if (newItems.length < limit) {
          hasMore = false;
          update();
        }

        datalist.addAll(list);

        // Simpan hasil fetch ke GetStorage
        storage.write('kitiran_pbb', datalist.map((e) => e.toJson()).toList());
        logInfo(
            "Data kitiran_pbb disimpan ke storage: ${datalist.length} items");
      } else {
        logError(
            "Gagal memuat data Kitiran: ${response.statusCode} - ${response.reasonPhrase}");
        EasyLoading.showError("Gagal memuat data (${response.statusCode})");
      }
      EasyLoading.dismiss();
    } catch (error) {
      logError("Terjadi kesalahan: $error");
      EasyLoading.showError("Terjadi kesalahan saat memuat data.");
    } finally {
      isLoading = false;
      EasyLoading.dismiss();
      update();
    }
  }

  Future FetchKitiranThenSync(kelurahan, rt) async {
    EasyLoading.show(
        status: "Sedang Memuat Data Kitiran",
        maskType: EasyLoadingMaskType.clear);
    datalist.clear();

    if (isLoading) return;

    const limit = 18;
    final url = Uri.parse(
        '${URL_APP}/ekitiran/kitiran_list_thensync.php?kelurahan=$kelurahan&rt=$rt&tahun=$tahun_pbb');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List newItems =
            (json.decode(response.body) as Map<String, dynamic>)["data"];
        final list =
            newItems.map<ModelKitiran>((json) => ModelKitiran.fromJson(json));
        page++;
        isLoading = false;

        if (newItems.length < limit) {
          hasMore = false;
          update();
        }

        datalist.addAll(list);

        // Simpan hasil fetch ke GetStorage
        storage.write('kitiran_pbb', datalist.map((e) => e.toJson()).toList());
        logInfo(
            "Data kitiran_pbb disimpan ke storage: ${datalist.length} items");
      } else {
        logError(
            "Gagal memuat data Kitiran: ${response.statusCode} - ${response.reasonPhrase}");
        EasyLoading.showError("Gagal memuat data (${response.statusCode})");
      }
      EasyLoading.dismiss();
    } catch (error) {
      logError("Terjadi kesalahan: $error");
      EasyLoading.showError("Terjadi kesalahan saat memuat data.");
    } finally {
      isLoading = false;
      EasyLoading.dismiss();
      update();
    }
  }

  Future FetchKitiranOffline() async {
    datalist.clear();
    final box = GetStorage();
    List<dynamic>? cache = box.read('kitiran_pbb');

    if (cache != null) {
      // Decode data dan konversi ke List<ModelKitiran>
      List<ModelKitiran> kitiranList = cache
          .map((e) => ModelKitiran.fromJson(e as Map<String, dynamic>))
          .toList();

      // Tampilkan data
      datalist.addAll(kitiranList);
      update();
    } else {
      logInfo("Tidak ada data offline tersedia");
    }
  }

  void refreshData(kelurahan, rt) async {
    EasyLoading.show(
        status: "Sedang Memuat Data Kitiran",
        maskType: EasyLoadingMaskType.clear);
    datalist.clear();

    // Ambil data dari API
    final url = Uri.parse(
        '${URL_APP}/ekitiran/kitiran_list.php?kelurahan=$kelurahan&rt=$rt&tahun=$tahun_pbb');
    final response = await http.get(url);

    List newItems =
        (json.decode(response.body) as Map<String, dynamic>)["data"];
    final List<ModelKitiran> apiData = newItems
        .map<ModelKitiran>((json) => ModelKitiran.fromJson(json))
        .toList();

    // Ambil data dari GetStorage
    final localStorage = GetStorage().read<List<dynamic>>("kitiran_pbb") ?? [];
    final List<ModelKitiran> localData =
        localStorage.map((item) => ModelKitiran.fromJson(item)).toList();

    // Gabungkan data tanpa duplikasi berdasarkan NOP
    Map<String, ModelKitiran> combinedMap = {
      for (var item in apiData) item.nop: item,
      for (var item in localData) item.nop: item,
    };
    datalist.addAll(combinedMap.values);

    // Write data gabungan ke GetStorage
    GetStorage().write(
      "kitiran_pbb",
      combinedMap.values.map((e) => e.toJson()).toList(),
    );
    EasyLoading.dismiss();
    isLoading = false;
    update();
  }

  void SimpanDataAkunRT() {
    getDefaultDialog().onConfirm(
      title: "Anda yakin telah Mengisi Data dengan Benar?",
      desc: "Pastikan data yang anda isi telah sesuai",
      kategori: "warning",
      handler: () {
        Get.back();
        ProsesDataRT();
        update();
      },
    );
  }

  Future<void> ProsesDataRT() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    bool isConnected = await isInternetConnected();

    if (isConnected) {
      var url = Uri.parse("${URL_APP}/ekitiran/user_rt_input.php");
      try {
        var response = await http.post(url, body: {
          "id_user_rt": "${id_user_rt.text}",
          "nama": "${nama.text}",
          "kecamatan": "${userrt_kecamatan.text}",
          "kelurahan": "${userrt_kelurahan.text}",
          "rt": "${userrt_rt.text}",
        });

        var data = json.decode(response.body);

        if (data['success'] != null && data['data'] != null) {
          // Update RTModel dengan data dari response
          rtModel = RTModel(
            id_user_rt: data['data']['id_user_rt'],
            nama: data['data']['nama'],
            kecamatan: data['data']['kecamatan'],
            kelurahan: data['data']['kelurahan'],
            rt: data['data']['rt'],
            isSynced: true,
          );

          // Simpan ke GetStorage
          await storage.write('user_rt', rtModel.toJson());
          FetchKitiranThenSync(rtModel.kelurahan, rtModel.rt);
          logInfo(
              "Updated user_rt in GetStorage with Internet: ${jsonEncode(storage.read('user_rt'))}");

          Get.back(); // tutup bottomsheet data RT
          RawSnackbar_bottom(
            message: "${data['success']}",
            kategori: "success",
            duration: 3,
          );
        } else {
          RawSnackbar_top(
            message: "Gagal menyimpan data ke server.",
            kategori: "Error",
            duration: 3,
          );
        }
        EasyLoading.dismiss();
      } catch (e) {
        EasyLoading.dismiss();
        logError("Error during API request: $e");
        RawSnackbar_top(
          message: "Terjadi gangguan jaringan.",
          kategori: "Error",
          duration: 3,
        );
      }
    } else {
      EasyLoading.dismiss();
      // Jika tidak ada internet, simpan langsung ke GetStorage
      rtModel = RTModel(
        id_user_rt: id_user_rt.text,
        nama: nama.text,
        kecamatan: userrt_kecamatan.text,
        kelurahan: userrt_kelurahan.text,
        rt: userrt_rt.text,
        isSynced: false,
      );
      storage.write('user_rt', rtModel.toJson());
      logInfo(
          "Saved user_rt locally without internet: ${jsonEncode(storage.read('user_rt'))}");
      Get.back();
      RawSnackbar_bottom(
        message:
            "Data disimpan secara lokal karena tidak ada koneksi internet.",
        kategori: "success",
        duration: 3,
      );
    }

    EasyLoading.dismiss();
    update();
  }

  Future<void> syncUserRT(RTModel rtModel) async {
    var url = Uri.parse("${URL_APP}/ekitiran/user_rt_input.php");
    var response = await http.post(url, body: {
      "id_user_rt": "${rtModel.id_user_rt}",
      "nama": "${rtModel.nama}",
      "kecamatan": "${rtModel.kecamatan}",
      "kelurahan": "${rtModel.kelurahan}",
      "rt": "${rtModel.rt}",
    });

    var data = json.decode(response.body);

    if (data['success'] != null && data['data'] != null) {
      // Update RTModel dengan data dari response
      rtModel = RTModel(
        id_user_rt: data['data']['id_user_rt'],
        nama: data['data']['nama'],
        kecamatan: data['data']['kecamatan'],
        kelurahan: data['data']['kelurahan'],
        rt: data['data']['rt'],
        isSynced: true,
      );

      // Simpan ke GetStorage
      storage.write('user_rt', rtModel.toJson());
      logInfo(
          "Updated user_rt in GetStorage: ${jsonEncode(storage.read('user_rt'))}");

      RawSnackbar_bottom(
        message: "${data['success']}",
        kategori: "success",
        duration: 3,
      );
    } else {
      RawSnackbar_top(
        message: "Gagal menyimpan data ke server.",
        kategori: "Error",
        duration: 3,
      );
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

  void showBottomSheet({required String flag}) {
    // Baca seluruh data user_rt dari storage
    var userRTStorage = storage.read('user_rt') ?? {};

    id_user_rt.text = userRTStorage['id_user_rt'] ?? '';
    nama.text = userRTStorage['nama'] ?? '';
    userrt_kecamatan.text = userRTStorage['kecamatan'] ?? '';
    availableKelurahan = kelurahanByKecamatan[userRTStorage['kecamatan']] ?? [];
    userrt_kelurahan.text = userRTStorage['kelurahan'] ?? '';
    userrt_rt.text = userRTStorage['rt'] ?? '';

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: GestureDetector(
          onTap: () {
            dismissKeyboard();
          },
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
                              flag == "edit"
                                  ? SizedBox()
                                  : Texts.body1(
                                      'Selamat Datang di Aplikasi E-Kitiran PBB RT, Lengkapi terlebih dahulu data RT anda dibawah ini untuk Lanjut.',
                                      isBold: true,
                                      maxLines: 3,
                                      textAlign: TextAlign.center),
                              SizedBox(height: 8.h),
                              Container(
                                // width: 167.w,
                                child: TextFields.defaultTextField2(
                                  title: "Nama Lengkap Ketua RT",
                                  controller: controller.nama,
                                  isLoading: controller.isLoading,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  // prefixIcon: Icons.contact_emergency,
                                  borderColor: MainColorGreen,
                                  validator: true,
                                ),
                              ),
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
                                                  width: 1.0,
                                                  color: Colors.grey),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 2.h,
                                                    horizontal: 10.h),
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
                                                  width: 1.0,
                                                  color: Colors.blue),
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
                                              hint:
                                                  const Text("Pilih Kecamatan"),
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
                                          "Pilih Kelurahan",
                                        ),
                                        InputDecorator(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.grey),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 2.h,
                                                    horizontal: 10.h),
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
                                                  width: 1.0,
                                                  color: Colors.blue),
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
                                              hint:
                                                  const Text("Pilih Kelurahan"),
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
                                              items: controller
                                                  .availableKelurahan
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
                                  dropdownValue:
                                      controller.userrt_rt.text.isEmpty
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
                                  easyThrottle(
                                    handler: () {
                                      controller.SimpanDataAkunRT();
                                    },
                                  );
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
      ),
      isDismissible: flag == "edit" ? true : false,
    );
  }

  void showSyncProgressDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      content: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Texts.caption(
                "Terhubung ke Internet! sedang Sinkronisasi data ke database online, Mohon Tunggu & jangan menutup Aplikasi sampai proses Selesai",
                textAlign: TextAlign.center,
                maxLines: 4),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progressSync.value,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
            ),
            SizedBox(height: 10),
            Text(
              "${(progressSync.value * 100).toStringAsFixed(1)}% Selesai",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void hapusData(String NopHapus) async {
    EasyLoading.show(
        status: "Sedang menghapus Data Kitiran",
        maskType: EasyLoadingMaskType.clear);
    // Membaca data dari GetX Storage
    var storedData = storage.read('kitiran_pbb');

    // Cek apakah data ditemukan di storage
    if (storedData != null) {
      // Pastikan storedData adalah List<dynamic>
      List<dynamic> jsonData = storedData;

      // Debug untuk melihat data yang ada
      // print('Data sebelum dihapus: $jsonData');

      // Gunakan try-catch untuk menangani kesalahan jika item tidak ditemukan
      var itemToRemove;
      try {
        itemToRemove = jsonData.firstWhere((item) => item['nop'] == NopHapus);
      } catch (e) {
        itemToRemove =
            null; // Jika item tidak ditemukan, itemToRemove akan menjadi null
      }

      // Periksa apakah data ditemukan dan valid
      if (itemToRemove != null && itemToRemove is Map<String, dynamic>) {
        logInfo("disini");
        // Mengecek apakah data isSynced == false
        ModelKitiran modelKitiran = ModelKitiran.fromJson(itemToRemove);
        if (modelKitiran.isSynced == false) {
          // Jika isSynced false, langsung hapus dari GetX Storage
          jsonData.removeWhere((item) => item['nop'] == NopHapus);
          // Tulis data yang telah diubah kembali ke GetX Storage
          storage.write('kitiran_pbb', jsonData);
          FetchKitiranOffline();
          print('Data berhasil dihapus dari GetX Storage.');
          update();
        } else {
          bool isConnected = await isInternetConnected();

          if (isConnected) {
            // Jika isSynced true, kirim request POST ke server untuk menghapus data
            final url = Uri.parse(
                '${URL_APP}/ekitiran/kitiran_hapus.php?nop=$NopHapus');

            try {
              // Kirim request POST
              final response = await http.post(url);
              final responseData = json.decode(response.body);

              if (response.statusCode == 200) {
                // Setelah berhasil dihapus di server, hapus data dari GetX Storage
                if (responseData['status'] == 'success') {
                  jsonData.removeWhere((item) => item['nop'] == NopHapus);
                  storage.write('kitiran_pbb', jsonData);
                  FetchKitiranOffline();
                  update();
                } else {
                  print(
                      'Gagal menghapus data di server: ${responseData['message']}');
                }
                update();
                print('Data berhasil dihapus dari server dan GetX Storage.');
              } else {
                print('Gagal menghapus data di server: ${response.statusCode}');
              }
            } catch (e) {
              print('Terjadi kesalahan saat mengirim request: $e');
            }
            EasyLoading.dismiss();
          } else {
            EasyLoading.showError(
                "Untuk menghapus data ini, harus terhubung Internet",
                duration: Duration(seconds: 4));
          }
        }
      } else {
        print(
            'Data dengan NOP $NopHapus tidak ditemukan atau format data tidak valid.');
      }
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      print('Tidak ada data yang disimpan di GetX Storage.');
    }
  }

  Future<bool> isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();

// Jika tidak ada koneksi sama sekali, langsung return false
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Coba melakukan ping ke Google DNS untuk memastikan akses internet
    // Set timeout agar tidak menunggu terlalu lama
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 2)); // Timeout 2 detik
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet benar-benar aktif
      }
    } catch (e) {
      return false; // Tidak bisa mengakses internet
    }

    return false;
  }

  void checkAndDownloadPBBData() async {
    int? storedVersion = storage.read<int>('versi_data_pbb');

    // Jika versi belum ada atau lebih rendah dari versi yang diinginkan
    if (storedVersion == null || storedVersion < dataPBBVersion) {
      print("Mulai download data PBB versi baru...");
      await DownloadDataPBBJson();

      // Setelah selesai, simpan versi terbaru ke storage
      storage.write('versi_data_pbb', dataPBBVersion);
      print("Download selesai, versi_data_pbb disimpan: $dataPBBVersion");
    } else {
      print(
          "Data PBB sudah versi terbaru ($storedVersion). Tidak perlu download.");
    }
  }

  Future<void> DownloadDataPBBJson() async {
    //EasyLoading.show(status: "Sedang download Data PBB JSON");
    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('API_BPD_ETAM:API_BPD_ETAM'))}';
      final response = await http.get(
        Uri.parse(
            "https://pajak.bontangkita.id/sismiop/api/informasi/sync_sppts_list/${tahun_pbb}"),
        headers: {'Authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        String jsonData = response.body;

        // Parsing JSON dan ambil bagian 'sppts' yang berupa List
        final parsedData = json.decode(jsonData);
        final List<dynamic> informasi = parsedData['data']['sppts'];

        // Simpan ke GetStorage
        await saveJsonToStorage(informasi);

        print('Data PBB berhasil disimpan ke GetStorage.');
      } else {
        print('Gagal mendapatkan data: ${response.statusCode}');
      }
      //EasyLoading.dismiss();
    } catch (e) {
      print('Terjadi kesalahan: $e');
      // EasyLoading.dismiss();
    }
  }

  Future<void> saveJsonToStorage(List<dynamic> informasi) async {
    storage.write('data_pbb', informasi);
    print('Data PBB berhasil disimpan di GetStorage.');
  }

  Future<void> loadJsonFromStorage() async {
    var dataPBB = storage.read('data_pbb');
    if (dataPBB != null) {
      print("Data PBB dari GetStorage: ${jsonEncode(dataPBB)}");
    } else {
      print("Tidak ada data PBB di GetStorage.");
    }
  }

  void GetDetailSPPT(ModelKitiran itemSPPT) {
    Get.defaultDialog(
      title: "Detail SPPT",
      radius: 12.r,
      titlePadding: EdgeInsets.zero,
      content: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 115.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "NAMA PEMILIK :",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            maxLines: 2,
                            "${itemSPPT.nama}",
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 0.5.w),
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 115.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "NOP :",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            "${itemSPPT.nop}",
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 248, 248, 248)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 230.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "ALAMAT PEMILIK :",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            "${itemSPPT.alamat}",
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 115.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "KECAMATAN OBJEK",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            "${itemSPPT.kecamatanOp}",
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 0.5.w),
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 115.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "KELURAHAN OBJEK",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            "${itemSPPT.kelurahanOp}",
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 248, 248, 248)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 230.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "ALAMAT OBJEK :",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            "${itemSPPT.alamatOp}",
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 115.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "JML PAJAK",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(itemSPPT.jumlahPajak.toString() == '' ? '0' : itemSPPT.jumlahPajak.toString()))}",
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 0.5.w),
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Container(
                      width: 115.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.captionXs2(
                            "STATUS BAYAR :",
                            isBold: true,
                            color: Color.fromARGB(255, 71, 80, 90),
                          ),
                          Texts.captionXs2(
                            "${itemSPPT.statusPembayaranSppt}",
                            maxLines: 5,
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            itemSPPT.isSynced == true
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8.0), // opsional, untuk sudut membulat
                    child: CachedNetworkImage(
                      imageUrl:
                          "${URL_APP}/upload_bukti_kitiran/${itemSPPT.bukti}",
                      width: 210.w,
                      height: 150.h,
                      fit: BoxFit.contain, // Atur ini sesuai kebutuhan
                      placeholder: (context, url) => ShimmerWidget.rectangular(
                        width: 210.w,
                        height: 150.h,
                        baseColor: shadowColor,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/image.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8.0), // opsional, untuk sudut membulat
                    child: Image.file(
                      width: 210.w,
                      height: 150.h,
                      File(itemSPPT.bukti),
                      fit: BoxFit.contain,
                    ),
                  ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 80.w,
          child: Buttons.gradientButton(
            handler: () {
              Get.back();
            },
            widget: Texts.button("Ok"),
            borderSide: false,
            gradient: [Colors.cyan, Colors.indigo],
          ),
        ),
      ],
    );
  }

  Future<void> clearImagePickerCache(String fileName) async {
    final directory = await getTemporaryDirectory();
    final cacheDirectory = Directory(directory.path);

    final cleanFileName = fileName.replaceFirst(RegExp(r'^scaled_'), '');

    if (cacheDirectory.existsSync()) {
      print("Cache directory: ${cacheDirectory.path}");
      for (var file in cacheDirectory.listSync(recursive: true)) {
        if (file is File && file.path.contains(cleanFileName)) {
          print('Deleting image cache: ${file.path}');
          await file.delete();
        }
      }
    }
  }

  void changeValueTahunCetak(String? newValue) {
    tahun_cetak.text = newValue!;
    update();
  }

  Future<void> backupKitiranPbb() async {
    try {
      final storage = GetStorage();
      List<dynamic> rawData = storage.read<List<dynamic>>('kitiran_pbb') ?? [];

      if (rawData.isEmpty) {
        print("Tidak ada data untuk di-backup.");
        return;
      }

      // Menyiapkan data untuk dikirim
      Map<String, dynamic> dataToSend = {
        "rt": rtModel.rt,
        "kelurahan": rtModel.kelurahan,
        "tahun": tahun_pbb,
        "data_backup": rawData, // Isi data_backup dengan rawData
      };

      String apiUrl = "${URL_APP}/ekitiran/backup_kitiran.php";

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(dataToSend), // Kirimkan data yang sudah terstruktur
      );

      final responseData = jsonDecode(response.body);
      print(responseData["message"]);
    } catch (e) {
      print("Error saat backup: $e");
      Get.snackbar("Backup Gagal", "Pastikan koneksi internet stabil.");
    }
  }
}
