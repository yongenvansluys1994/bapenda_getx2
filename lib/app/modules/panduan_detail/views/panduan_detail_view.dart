import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/panduan_detail_controller.dart';

class PanduanDetailView extends GetView<PanduanDetailController> {
  const PanduanDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: "${controller.dataArgument.nmPanduan}",
            leading: true,
            isLogin: true),
        body: GetBuilder<PanduanDetailController>(
            init: PanduanDetailController(),
            builder: (controller) {
              return ListView.builder(
                itemCount: controller.dataArgument.listFoto.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://simpatda.bontangkita.id/api_ver2/panduan/${controller.dataArgument.nmFolder}/${controller.dataArgument.listFoto[index]}",
                        height: 520.h,
                        width: 320.w,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            ShimmerWidget.rectangular(
                          height: 170.h,
                          width: 320.w,
                          baseColor: shadowColor,
                        ),
                        errorWidget: ((context, url, error) => Image.asset(
                              'images/image.png',
                              fit: BoxFit.cover,
                              height: 170.h,
                              width: 320.w,
                            )),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
