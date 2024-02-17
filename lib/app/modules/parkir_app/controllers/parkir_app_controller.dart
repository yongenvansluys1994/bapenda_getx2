import 'package:bapenda_getx2/app/modules/parkir_app/models/model_configparkir.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class ParkirAppController extends GetxController {
  late ModelConfigParkir modelConfigParkir;
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  DateTime now = DateTime.now();
  int? harga_motor;
  int? harga_mobil;
  TextEditingController nama_usaha = TextEditingController();
  TextEditingController alamat_usaha = TextEditingController();
  TextEditingController harga_roda2 = TextEditingController();
  TextEditingController harga_roda4 = TextEditingController();
  // Format the date and time
  String? formattedDate;

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    box.write("config_parkir", {
      "nama_usaha": "Bontang Plaza",
      "alamat_usaha": "Jalan P Antasari no 71",
      "harga_roda2": "2000",
      "harga_roda4": "3000",
    });
    var configparkir = GetStorage().read("config_parkir");
    modelConfigParkir = ModelConfigParkir.fromJson(configparkir);

    formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
    harga_motor = 2000;
    harga_mobil = 5000;

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
    nama_usaha.text = modelConfigParkir.namaUsaha;
    alamat_usaha.text = modelConfigParkir.alamatUsaha;
    harga_roda2.text = modelConfigParkir.hargaRoda2;
    harga_roda4.text = modelConfigParkir.hargaRoda4;
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
    final box = GetStorage();
    box.write("config_parkir", {
      "nama_usaha": "${nama_usaha.text}",
      "alamat_usaha": "${alamat_usaha.text}",
      "harga_roda2": "${harga_roda2.text.replaceAll(',', '')}",
      "harga_roda4": "${harga_roda4.text.replaceAll(',', '')}",
    });

    var configparkir = box.read("config_parkir");
    modelConfigParkir = ModelConfigParkir.fromJson(configparkir);
    print(box.read("config_parkir"));
  }

  void PrintMotor() async {
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
    await SunmiPrinter.printText('NAMA USAHA',
        style: SunmiStyle(fontSize: SunmiFontSize.LG));
    await SunmiPrinter.setCustomFontSize(20); // SET CUSTOM FONT 12
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('Alamat',
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
        "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(harga_motor.toString()))}",
        style: SunmiStyle(bold: true, fontSize: SunmiFontSize.XL));
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('_______________________________');
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('Terima Kasih atas kunjungan anda');
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.exitTransactionPrint(true);
  }

  void PrintMobil() async {
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
    await SunmiPrinter.printText('NAMA USAHA',
        style: SunmiStyle(fontSize: SunmiFontSize.LG));
    await SunmiPrinter.setCustomFontSize(20); // SET CUSTOM FONT 12
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('Alamat',
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
        "${NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(int.parse(harga_mobil.toString()))}",
        style: SunmiStyle(bold: true, fontSize: SunmiFontSize.XL));
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('_______________________________');
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText('Terima Kasih atas kunjungan anda');
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.exitTransactionPrint(true);
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
