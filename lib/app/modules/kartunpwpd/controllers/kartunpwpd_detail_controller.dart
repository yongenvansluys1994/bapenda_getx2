import 'dart:io';
import 'dart:typed_data';

import 'package:bapenda_getx2/app/modules/kartunpwpd/models/model_kartudata.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class KartunpwpdDetailController extends GetxController {
  late ModelKartuData dataArgument;
  int profLevel = 0;
  final SScontroller = ScreenshotController();
  @override
  void onInit() {
    super.onInit();
    dataArgument = Get.arguments;
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);

    final text = "tes";
    await Share.shareFiles([image.path], text: text);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final name = 'Kartu Data NPWPD';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    RawSnackbar_top(
        message: "Kartu Data NPWPD telah di download, Lihat di Galeri Foto",
        kategori: "success",
        duration: 2);

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
