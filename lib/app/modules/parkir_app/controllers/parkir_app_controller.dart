import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/parkir_app/models/model_configparkir.dart';
import 'package:bapenda_getx2/app/modules/parkir_app/models/model_parkirtrans.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class ParkirAppController extends GetxController {
  final box = GetStorage();
  final PageController pageController = PageController();
  int currentPage = 0;
  late ModelConfigParkir modelConfigParkir;
  late AuthModel authModel;
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  DateTime now = DateTime.now();
  TextEditingController nama_usaha = TextEditingController();
  TextEditingController alamat_usaha = TextEditingController();
  TextEditingController harga_roda2 = TextEditingController();
  TextEditingController harga_roda4 = TextEditingController();
  int? harga_motor;
  int? harga_mobil;
  String? valuenpwpd;
  List dropdown_npwpd = []; //edited line
  // Format the date and time
  String? formattedDate;

  bool hasMore = true;
  int page = 1;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  final controllerScroll = ScrollController();
  RxList<ModelParkirTrans> datalist = <ModelParkirTrans>[].obs;

  List<Map<String, dynamic>> myList = [];

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  @override
  void onInit() {
    super.onInit();

    authModel = Get.arguments;
    getNPWPD();
    myList = box.read<List<Map<String, dynamic>>>('myList') ?? [];

    var configparkir = GetStorage().read("config_parkir");

    if (configparkir == null) {
      print("asdasda");
      box.write("config_parkir", {
        "npwpd": "",
        "nama_usaha": "",
        "alamat_usaha": "",
        "harga_roda2": "",
        "harga_roda4": "",
      });
      configparkir = GetStorage().read("config_parkir");
    }

    modelConfigParkir = ModelConfigParkir.fromJson(configparkir);

    valuenpwpd = modelConfigParkir.npwpd;
    nama_usaha.text = modelConfigParkir.namaUsaha;
    alamat_usaha.text = modelConfigParkir.alamatUsaha;
    harga_roda2.text = modelConfigParkir.hargaRoda2;
    harga_roda4.text = modelConfigParkir.hargaRoda4;

    if (modelConfigParkir.npwpd != "") {
      fetch(authModel.nik);
    }

    controllerScroll.addListener(() {
      if (controllerScroll.position.maxScrollExtent ==
          controllerScroll.offset) {
        fetch(authModel.nik);
        update();
      }
    });

    formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);

    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        paperSize = size;
      });

      SunmiPrinter.printerVersion().then((String version) {
        printerVersion = version;
      });

      SunmiPrinter.serialNumber().then((String serial) {
        serialNumber = serial;
      });

      printBinded = isBind!;
    });

    update();
  }

  void updateValueDropdown(String value) async {
    valuenpwpd = value; //value kode_rekening  sesuai jenis pajak yg dipilih
    update();
  }

  Future<String> getNPWPD() async {
    //print(dataArgument.idRekening);
    var res = await http.get(
        Uri.parse(
            "${URL_APP}/parkir_app/get_npwpd.php?nik_user=${authModel.nik}"),
        headers: {"Accept": "application/json"});
    print(json.decode(res.body));
    var resBody = json.decode(res.body);
    dropdown_npwpd = resBody;
    update();
    // print(resBody);
    return "Sucess";
  }

  void onChangedRp2(String string) {
    string = '${formNum(
      string.replaceAll(',', ''),
    )}';
    update();
    harga_roda2.value = TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
    update();
  }

  void onChangedRp4(String string) {
    string = '${formNum(
      string.replaceAll(',', ''),
    )}';
    update();
    harga_roda4.value = TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
    update();
  }

  void simpanConfig() async {
    if (valuenpwpd == null ||
        nama_usaha.text == "" ||
        alamat_usaha.text == "" ||
        harga_roda2.text == "" ||
        harga_roda4.text == "") {
      RawSnackbar_bottom(
          message: "Semua form harus diisi", kategori: "error", duration: 3);
    } else {
      box.write("config_parkir", {
        "npwpd": "${valuenpwpd}",
        "nama_usaha": "${nama_usaha.text}",
        "alamat_usaha": "${alamat_usaha.text}",
        "harga_roda2": "${harga_roda2.text.replaceAll(',', '')}",
        "harga_roda4": "${harga_roda4.text.replaceAll(',', '')}",
      });

      var configparkir = box.read("config_parkir");
      modelConfigParkir = ModelConfigParkir.fromJson(configparkir);
      Get.back();
      EasyLoading.showSuccess("Berhasil simpan data");
      refreshData("${authModel.nik}");
    }
  }

  void PrintMotor() async {
    try {
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER); // Center align
      await SunmiPrinter.printText('E-TICKET PARKING',
          style: SunmiStyle(fontSize: SunmiFontSize.LG));
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER); // Center align
      await SunmiPrinter.printText('#1231231',
          style: SunmiStyle(fontSize: SunmiFontSize.LG));
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('_______________________________');
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText(
          '${modelConfigParkir.namaUsaha.toUpperCase()}',
          style: SunmiStyle(fontSize: SunmiFontSize.LG));
      await SunmiPrinter.setCustomFontSize(20); // SET CUSTOM FONT 12
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('${modelConfigParkir.alamatUsaha}',
          style: SunmiStyle(fontSize: SunmiFontSize.MD));
      await SunmiPrinter.resetFontSize(); // Reset font to medium size
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('_______________________________');
      await SunmiPrinter.printText('Jenis Kendaraan :',
          style: SunmiStyle(fontSize: SunmiFontSize.MD));
      await SunmiPrinter.printText('KENDARAAN RODA 2',
          style: SunmiStyle(bold: true, fontSize: SunmiFontSize.LG));
      await SunmiPrinter.printText('Waktu :',
          style: SunmiStyle(fontSize: SunmiFontSize.MD));
      await SunmiPrinter.printText('${formattedDate}',
          style: SunmiStyle(bold: true, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(2);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText(
          "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(modelConfigParkir.hargaRoda2.toString()))}",
          style: SunmiStyle(bold: true, fontSize: SunmiFontSize.XL));
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('_______________________________');
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('Terima Kasih atas kunjungan anda');
      await SunmiPrinter.lineWrap(4);
      await SunmiPrinter.exitTransactionPrint(true);
      bool isConnected = await isInternetConnected();
      if (isConnected) {
        print("Internet Connected");
        insert_transaksi(
            modelConfigParkir.npwpd, "motor", modelConfigParkir.hargaRoda2);
        var myListStorage =
            box.read<List<Map<String, dynamic>>>('myList') ?? [];
        if (myListStorage.isNotEmpty) {
          var response = await dio.post('/parkir_app/insert_transaksi.php',
              data: jsonEncode(
                  myListStorage)); //send value from myListStorage to online
          if (response.statusCode == 200) {
            RawSnackbar_bottom(
                message:
                    "Terhubung ke internet! beberapa data storage offline telah dikirim ke database online",
                kategori: "success",
                duration: 2);
            // Show notification
            box.remove('myList');
            myList.clear();
            var myListStorage =
                box.read<List<Map<String, dynamic>>>('myList') ?? [];
            print(jsonEncode(myListStorage));
          }
        }
      } else {
        print("Internet Not Connect");
        final Map<String, dynamic> newData = {
          'nik': authModel.nik,
          'npwpd': modelConfigParkir.npwpd,
          'jenis': "motor",
          'nominal': modelConfigParkir.hargaRoda2,
          'date': DateTime.now().toIso8601String()
        };
        myList.add(newData);
        // Save updated list to storage
        box.write('myList', myList);
        var myListStorage =
            box.read<List<Map<String, dynamic>>>('myList') ?? [];
        print(jsonEncode(myListStorage));
        // Perform network operation
        // Example: fetch data from the internet
      }
    } catch (e) {
      EasyLoading.showError(
          "Terjadi error saat printing, bluetooth harus aktif & kertas tersedia.");
    }
  }

  void PrintMobil() async {
    try {
      await SunmiPrinter.initPrinter();
      await SunmiPrinter.startTransactionPrint(true);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER); // Center align
      await SunmiPrinter.printText('E-TICKET PARKING',
          style: SunmiStyle(fontSize: SunmiFontSize.LG));
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER); // Center align
      await SunmiPrinter.printText('#1231231',
          style: SunmiStyle(fontSize: SunmiFontSize.LG));
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('_______________________________');
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText(
          '${modelConfigParkir.namaUsaha.toUpperCase()}',
          style: SunmiStyle(fontSize: SunmiFontSize.LG));
      await SunmiPrinter.setCustomFontSize(20); // SET CUSTOM FONT 12
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('${modelConfigParkir.alamatUsaha}',
          style: SunmiStyle(fontSize: SunmiFontSize.MD));
      await SunmiPrinter.resetFontSize(); // Reset font to medium size
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('_______________________________');
      await SunmiPrinter.printText('Jenis Kendaraan :',
          style: SunmiStyle(fontSize: SunmiFontSize.MD));
      await SunmiPrinter.printText('KENDARAAN RODA 4',
          style: SunmiStyle(bold: true, fontSize: SunmiFontSize.LG));
      await SunmiPrinter.printText('Waktu :',
          style: SunmiStyle(fontSize: SunmiFontSize.MD));
      await SunmiPrinter.printText('${formattedDate}',
          style: SunmiStyle(bold: true, fontSize: SunmiFontSize.MD));
      await SunmiPrinter.lineWrap(2);
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText(
          "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(modelConfigParkir.hargaRoda4.toString()))}",
          style: SunmiStyle(bold: true, fontSize: SunmiFontSize.XL));
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('_______________________________');
      await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
      await SunmiPrinter.printText('Terima Kasih atas kunjungan anda');
      await SunmiPrinter.lineWrap(4);
      await SunmiPrinter.exitTransactionPrint(true);
      bool isConnected = await isInternetConnected();
      if (isConnected) {
        print("Internet Connected");
        insert_transaksi(
            modelConfigParkir.npwpd, "mobil", modelConfigParkir.hargaRoda4);
        var myListStorage =
            box.read<List<Map<String, dynamic>>>('myList') ?? [];
        if (myListStorage.isNotEmpty) {
          var response = await dio.post('/parkir_app/insert_transaksi.php',
              data: jsonEncode(
                  myListStorage)); //send value from myListStorage to online
          if (response.statusCode == 200) {
            RawSnackbar_bottom(
                message:
                    "Terhubung ke internet! beberapa data storage offline telah dikirim ke database online",
                kategori: "success",
                duration: 2);
            // Show notification
            box.remove('myList');
            myList.clear();
            var myListStorage =
                box.read<List<Map<String, dynamic>>>('myList') ?? [];
            print(jsonEncode(myListStorage));
          }
        }
      } else {
        print("Internet Not Connect");
        final Map<String, dynamic> newData = {
          'nik': authModel.nik,
          'npwpd': modelConfigParkir.npwpd,
          'jenis': "mobil",
          'nominal': modelConfigParkir.hargaRoda4,
          'date': DateTime.now().toIso8601String()
        };
        myList.add(newData);
        // Save updated list to storage
        box.write('myList', myList);
        var myListStorage =
            box.read<List<Map<String, dynamic>>>('myList') ?? [];
        print(jsonEncode(myListStorage));
        // Perform network operation
        // Example: fetch data from the internet
      }
    } catch (e) {
      EasyLoading.showError(
          "Terjadi error saat printing, bluetooth harus aktif & kertas tersedia.");
    }
  }

  Future fetch(nik) async {
    if (isLoading) return;
    const limit = 18;
    final url = Uri.parse(
        '${URL_APP}/parkir_app/get_transaksi.php?nik_user=$nik&page=$page&limit=$limit');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List newItems =
          (json.decode(response.body) as Map<String, dynamic>)["data"];
      final list = newItems
          .map<ModelParkirTrans>((json) => ModelParkirTrans.fromJson(json));
      page++;
      isLoading = false;

      if (newItems.length < limit) {
        hasMore = false;
        update();
      }
      datalist.addAll(list);
      update();
    }
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 25),
      receiveTimeout: Duration(seconds: 25),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  void refreshData(String nik) async {
    datalist.clear();
    const limit = 18;
    final url = Uri.parse(
        '${URL_APP}/parkir_app/get_transaksi.php?nik_user=$nik&page=1&limit=$limit');
    final response = await http.get(url);
    List newItems =
        (json.decode(response.body) as Map<String, dynamic>)["data"];
    final list = newItems
        .map<ModelParkirTrans>((json) => ModelParkirTrans.fromJson(json));

    isLoading = false;
    datalist.addAll(list);

    update();
  }

  void insert_transaksi(String npwpd, String jenis, String nominal) async {
    var response = await dio.post('/parkir_app/insert_transaksi.php', data: [
      {
        'nik': authModel.nik,
        'npwpd': npwpd,
        'jenis': jenis,
        'nominal': nominal,
        'date': DateTime.now().toIso8601String(),
      }
    ]);
    if (response.statusCode == 200) {
      refreshData("${authModel.nik}");
    }
  }

  Future<bool> isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }
}
