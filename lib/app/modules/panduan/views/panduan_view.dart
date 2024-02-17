import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
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
        padding: EdgeInsets.all(8),
        child: Obx(
          () => GridView.builder(
              itemCount: controller.documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                var datalist = controller.documents[index];
                //mengatasi error null timestamp saat sendchat

                // end mengatasi error null timestamp saat sendchat
                return InkWell(
                    onTap: () {},
                    child: Container(
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
                          onTap: () {},
                          splashColor: Color.fromARGB(255, 224, 253, 246),
                          splashFactory: InkSplash.splashFactory,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 1.w, bottom: 1.w, left: 1.w, right: 1.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 170.w,
                                  height: 140.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10.r), // Adjust the radius as needed
                                    child: Image.network(
                                      "https://img.youtube.com/vi/${datalist['url_video']}/0.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Texts.caption('${datalist['judul']}',
                                          maxLines: 2,
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
        ),
      ),
    );
  }
}
