import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/custtombottombar.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/kartunpwpd_controller.dart';

class KartunpwpdView extends GetView<KartunpwpdController> {
  const KartunpwpdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Daftar Kartu Data",
          leading: false,
          isLogin: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70.5.h,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColor),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                      topRight: Radius.circular(48),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          offset: Offset(5, 5),
                          color: lightBlueColor.withOpacity(0.4)),
                      BoxShadow(
                          blurRadius: 7,
                          offset: Offset(-2, -2),
                          color: lightBlueColor.withOpacity(0.4))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kartu Data",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              GetBuilder<KartunpwpdController>(
                init: KartunpwpdController(Get.find<Api>()),
                builder: (controller) {
                  if (controller.isFailed) {
                    return NoData();
                  }

                  if (controller.isEmpty) {
                    return NoData(); //menampilkan lotties no data
                  }

                  if (controller.isLoading) {
                    return ShimmerWidget.Items1();
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.datalist.length,
                      itemBuilder: (context, index) {
                        var dataobjek = controller.datalist[index];

                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.KARTUNPWPD_DETAIL,
                                arguments: controller.datalist[index]);
                          },
                          child: Container(
                            height: 110.h,
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/listview2.png"),
                                          fit: BoxFit.fill),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(8, 6),
                                            color: lightGreenColor
                                                .withOpacity(0.3)),
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(-1, -5),
                                            color: lightGreenColor
                                                .withOpacity(0.3))
                                      ]),
                                ),
                                Container(
                                  height: 100.h,
                                  margin: EdgeInsets.only(
                                      left: 20, top: 8, right: 17),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${dataobjek.jenispajak}",
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey[800]),
                                      ),
                                      Text(
                                        "${dataobjek.npwpd}",
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey[800]),
                                      ),
                                      Text(
                                        "${dataobjek.namaUsaha}",
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey[800]),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  height: 100.h,
                                  margin: EdgeInsets.only(
                                    left: 130,
                                    top: 8,
                                    right: 3,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                new Container(width: 0, height: 0),
                              ],
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 60.w,
            height: 60.h,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: gradientColor)),
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: customButtomBar());
  }
}
