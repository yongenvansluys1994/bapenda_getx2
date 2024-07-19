import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import '../controllers/detailscreen_controller.dart';

class DetailscreenView extends GetView<DetailscreenController> {
  const DetailscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: "Detail Screen", leading: true, isLogin: true),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: GestureDetector(
            child: GetBuilder<DetailscreenController>(
              init: DetailscreenController(),
              builder: (controller) {
                return Center(
                    child: Container(
                        child: PhotoView(
                  imageProvider:
                      NetworkImage("https://yongen-bisa.com/bapenda_app/upload/${controller.url_image}"),
                )));
              },
            ),
            onTap: () {
              //Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
