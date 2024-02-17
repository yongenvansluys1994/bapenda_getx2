import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Dividers {
  static Container vertical({required int height}) {
    return Container(
      //aris
      margin: EdgeInsets.symmetric(
        horizontal: 5.h,
      ),
      height: height.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color: shadowColor,
        ),
      ),
    );
  }

  static Container horizontal() {
    return Container(
      //garis divider pakai container
      margin: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      width: Get.width.w,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color: shadowColor,
        ),
      ),
    );
  }
}
