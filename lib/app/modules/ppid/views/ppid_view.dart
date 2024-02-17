import 'package:bapenda_getx2/app/core/api/api.dart';
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

import '../controllers/ppid_controller.dart';

class PpidView extends GetView<PpidController> {
  const PpidView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "PPID", leading: true, isLogin: true),
      body: GetBuilder<PpidController>(
        init: PpidController(Get.find<Api>()),
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
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.datalist.length,
              itemBuilder: (context, index) {
                var dataitem = controller.datalist[index];

                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.ADS_DETAIL, arguments: dataitem);
                  },
                  child: Container(
                    width: 330.w,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.w),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://yongen-bisa.com/bapenda_app/upload/${dataitem.urlImage}", // "${URL_APP}/upload/${dataitem.urlImage}",
                            height: 170.h,
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
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 310.w,
                          child: Texts.body2(
                              "${dataitem.judul}", //${dataitem.judul}
                              maxLines: 2,
                              isBold: true),
                        ),
                        SizedBox(
                          width: 310.w,
                          child: Texts.body2(
                              "${dataitem.deskripsi}", //${dataitem.judul}
                              maxLines: 2,
                              textAlign: TextAlign.justify),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
