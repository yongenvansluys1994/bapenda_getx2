import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

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
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 1.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/npwpd_flutter.png"),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(8, 6),
                              color: lightGreenColor.withOpacity(0.3)),
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(-1, -5),
                              color: lightGreenColor.withOpacity(0.3))
                        ]),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 65, right: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NPWPD / RD",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Nama WP",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Nama Pemilik",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Alamat",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Image(
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/QR-CODE.png'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(left: 2, top: 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ": ${controller.dataArgument.npwpd}",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              ": ${controller.dataArgument.namaUsaha}",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              ": ${controller.dataArgument.namaPemilik}",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              ": ${controller.dataArgument.alamatPemilik} ",
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
