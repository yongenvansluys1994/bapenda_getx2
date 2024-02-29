import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import '../controllers/kartunpwpd_detail_controller.dart';

class KartunpwpdDetailView extends GetView<KartunpwpdDetailController> {
  const KartunpwpdDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detail Kartu Data",
        leading: true,
        isLogin: true,
      ),
      body: Column(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  height: MediaQuery.of(context).size.height / 4.3,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/header-top.png'),
                ),
              ]),
          SizedBox(
            height: 45,
          ),
          Screenshot(
            controller: controller.SScontroller,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 280.h,
                    width: MediaQuery.of(context).size.width / 1.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage("assets/images/npwpd_flutter.png"),
                          fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 95.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 1,
                                      "NPWPD/RD",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 180.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 1,
                                      ": ${controller.dataArgument.npwpd}",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 95.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 1,
                                      "Nama WP",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 180.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 2,
                                      ": ${controller.dataArgument.namaUsaha}",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 95.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 1,
                                      "Nama Pemilik",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 180.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 1,
                                      ": ${controller.dataArgument.namaPemilik}",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 95.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 1,
                                      "Alamat",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 180.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Texts.caption(
                                      maxLines: 2,
                                      ": ${controller.dataArgument.alamatUsaha}",
                                      color: Color.fromARGB(255, 59, 59, 59),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Image(
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/QR-CODE.png'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            easyThrottle(
                              handler: () async {
                                final image =
                                    await controller.SScontroller.capture();
                                if (image == null) return;
                                controller.saveAndShare(image);
                              },
                            );
                          },
                          child: Icon(Icons.share_sharp),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              width: 1,
                              color: Colors.white60,
                            ),
                            elevation: 10.0,
                            primary: lightBlueColor,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(17),
                          ),
                        ),
                        Text(
                          "Bagikan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            easyThrottle(
                              handler: () async {
                                final image =
                                    await controller.SScontroller.capture();
                                if (image == null) return;
                                await controller.saveImage(image);
                              },
                            );
                          },
                          child: Icon(Icons.download),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              width: 1,
                              color: Colors.white60,
                            ),
                            elevation: 10.0,
                            primary: lightBlueColor,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(17),
                          ),
                        ),
                        Text(
                          "Download",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
