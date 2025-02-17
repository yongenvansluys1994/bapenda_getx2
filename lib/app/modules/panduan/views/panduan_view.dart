import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/panduan_controller.dart';

class PanduanView extends GetView<PanduanController> {
  const PanduanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Panduan", leading: true, isLogin: true),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: GetBuilder<PanduanController>(
          init: PanduanController(),
          builder: (controller) {
            if (controller.isFailed) {
              return SizedBox(height: 175.h, child: ShimmerWidget.Items1());
            }

            if (controller.isEmpty) {
              return NoData(); //menampilkan lotties no data
            }

            if (controller.isLoading) {
              return SizedBox(height: 175.h, child: ShimmerWidget.Items1());
            }
            return GridView.builder(
                itemCount: controller.panduans.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  var datalist = controller.panduans[index];

                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 1),
                            blurRadius: 2.0)
                      ],
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: () {
                          Get.toNamed(Routes.PANDUAN_DETAIL,
                              arguments: datalist);
                        },
                        splashColor: Color.fromARGB(255, 224, 253, 246),
                        splashFactory: InkSplash.splashFactory,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 5.w, bottom: 5.w, left: 5.w, right: 5.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.w),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://simpatda.bontangkita.id/api_ver2/panduan/${datalist.nmFolder}/1.png",
                                  height: 150.h,
                                  width: 320.w,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      ShimmerWidget.rectangular(
                                    height: 150.h,
                                    width: 320.w,
                                    baseColor: shadowColor,
                                  ),
                                  errorWidget: ((context, url, error) =>
                                      Image.asset(
                                        'images/image.png',
                                        fit: BoxFit.cover,
                                        height: 150.h,
                                        width: 320.w,
                                      )),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Texts.caption(
                                          '${datalist.nmPanduan}',
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          isBold: false),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
