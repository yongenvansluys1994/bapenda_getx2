import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifikasi", leading: true, isLogin: true),
      body: const Center(
        child: Text(
          'NotifikasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
