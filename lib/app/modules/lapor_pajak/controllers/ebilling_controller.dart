import 'dart:io';
import 'dart:typed_data';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class EbillingController extends GetxController {
  //TODO: Implement EbillingController

  final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
  final SScontroller = ScreenshotController();
  int? persenDenda;
  int? denda_pajak;
  int? totalPajak;
  DateTime? dateNow;
  DateTime? dateBatasBayar;
  Duration? interval;
  late ModelGetpelaporanUser dataArgument;

  @override
  void onInit() {
    super.onInit();
    dataArgument = Get.arguments;
    dateNow = DateTime.now();
    dateBatasBayar = dataArgument.batasBayar;
    check_denda();
    update();
  }

  void check_denda() async {
    interval = dateNow!.difference(dateBatasBayar!);
    int selisih = interval!.inDays;
    int daysPerStep = 30; // Number of days for each step
    int maxDenda = 48; // Maximum denda value
    int steps = (selisih / daysPerStep).floor();

    int amount =
        int.parse(dataArgument.pajak); // Replace with the actual amount
    persenDenda = (steps * 2).clamp(0, maxDenda);
    denda_pajak = (amount * persenDenda! / 100).toInt();
    totalPajak = (denda_pajak! + int.parse(dataArgument.pajak));
    update();
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    final text = "tes";
    await Share.shareFiles([image.path], text: text);
    update();
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final name = 'EBILLING';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    Snackbar_bottom(
        title: "Berhasil",
        message: "E-Billing telah di download, Lihat di Galeri Foto",
        kategori: "success",
        duration: 2);
    update();

    return result['filePath'];
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
