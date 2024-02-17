import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/panduan_detail_controller.dart';

class PanduanDetailView extends GetView<PanduanDetailController> {
  const PanduanDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PanduanDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PanduanDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
