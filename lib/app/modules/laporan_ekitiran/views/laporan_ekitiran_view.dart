import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/laporan_ekitiran_controller.dart';

class LaporanEkitiranView extends GetView<LaporanEkitiranController> {
  const LaporanEkitiranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaporanEkitiranView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LaporanEkitiranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
