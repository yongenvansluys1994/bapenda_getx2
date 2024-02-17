import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/ads_detail_controller.dart';

class AdsDetailView extends GetView<AdsDetailController> {
  const AdsDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detail",
        leading: true,
        isLogin: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              child: Container(
                height: 700.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180.h,
                      child: Stack(
                        alignment: AlignmentDirectional(0, 1),
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://yongen-bisa.com/bapenda_app/upload/${controller.dataArgument.urlImage}", // "${URL_APP}/upload/${dataitem.urlImage}",
                                width: double.infinity,
                                height: 150.h,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    ShimmerWidget.rectangular(
                                  width: double.infinity,
                                  height: 150.h,
                                  baseColor: shadowColor,
                                ),
                                errorWidget: ((context, url, error) =>
                                    Image.asset(
                                      'images/image.png',
                                      width: double.infinity,
                                      height: 150.h,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.account_circle,
                                        color: Color(0xFF39D2C0),
                                        size: 24,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: Text(
                                          '${controller.dataArgument.wajibPajak}',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF39D2C0),
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF4B39EF),
                                            Color(0xFF39D2C0),
                                            Color(0xFFE0E3E7)
                                          ],
                                          stops: [0, 0.3, 1],
                                          begin: AlignmentDirectional(1, 0.98),
                                          end: AlignmentDirectional(-1, -0.98),
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2, 2, 2, 2),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.chevron_right_rounded,
                                            color: Color(0xFF14181B),
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                        child: Texts.headline6(
                            '${controller.dataArgument.judul}',
                            maxLines: 1)),
                    Divider(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                      child: Text(
                        '${controller.dataArgument.deskripsi}',
                        style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.7 //You can set your custom height here
                            ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
