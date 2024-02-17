import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Snackbar_top(
    {required String title,
    required String message,
    required String kategori,
    required int duration}) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    icon: Icon(kategori == "success" ? Icons.check_box : Icons.error,
        color: Colors.white, size: 20.w),
    snackPosition: SnackPosition.TOP,
    padding: EdgeInsets.all(6.sp),
    animationDuration: const Duration(milliseconds: 700),
    duration: Duration(seconds: duration),
    backgroundColor: Colors.white,
    backgroundGradient: kategori == "success"
        ? const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Color.fromARGB(255, 36, 211, 86),
              Color.fromARGB(255, 36, 211, 86),
            ],
          )
        : const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 255, 57, 57),
              Color.fromARGB(234, 255, 65, 65),
            ],
          ),
  );
}

Snackbar_bottom(
    {required String title,
    required String message,
    required String kategori,
    required int duration}) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    icon: Icon(kategori == "success" ? Icons.check_box : Icons.error,
        color: Colors.white, size: 20.w),
    snackPosition: SnackPosition.BOTTOM,
    padding: EdgeInsets.all(6.sp),
    animationDuration: const Duration(milliseconds: 700),
    duration: Duration(seconds: duration),
    backgroundColor: Colors.white,
    backgroundGradient: kategori == "success"
        ? const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Color.fromARGB(255, 36, 211, 86),
              Color.fromARGB(255, 36, 211, 86),
            ],
          )
        : const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 255, 57, 57),
              Color.fromARGB(234, 255, 65, 65),
            ],
          ),
  );
}

RawSnackbar_bottom(
    {required String message,
    required String kategori,
    required int duration,
    String? data}) {
  Get.rawSnackbar(
    messageText: data != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: TextStyle(fontSize: 13.sp)),
              Text("Nama WP : ${data}", style: TextStyle(fontSize: 13.sp)),
            ],
          )
        : Text(message, style: TextStyle(fontSize: 13.sp)),
    snackPosition: SnackPosition.BOTTOM,
    icon: Icon(kategori == "success" ? Icons.check_box : Icons.error,
        color: Colors.black, size: 20.w),
    backgroundColor: Colors.white,
    animationDuration: const Duration(milliseconds: 700),
    backgroundGradient: kategori == "success"
        ? const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(255, 143, 251, 156),
              Color.fromARGB(255, 130, 252, 144),
              Color.fromARGB(255, 120, 252, 135),
              Color.fromARGB(255, 93, 250, 111),
            ],
          )
        : const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 255, 57, 57),
              Color.fromARGB(234, 255, 65, 65),
            ],
          ),
    duration: Duration(seconds: duration),
  );
}

RawSnackbar_top(
    {required String message,
    required String kategori,
    required int duration}) {
  Get.rawSnackbar(
    messageText: Text(message, style: TextStyle(fontSize: 13.sp)),
    snackPosition: SnackPosition.TOP,
    icon: Icon(kategori == "success" ? Icons.check_box : Icons.error,
        color: Colors.black, size: 20.w),
    backgroundColor: Colors.white,
    animationDuration: const Duration(milliseconds: 700),
    backgroundGradient: kategori == "success"
        ? const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.7,
              0.9,
            ],
            colors: [
              Color.fromARGB(255, 143, 251, 156),
              Color.fromARGB(255, 130, 252, 144),
              Color.fromARGB(255, 120, 252, 135),
              Color.fromARGB(255, 93, 250, 111),
            ],
          )
        : const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 255, 57, 57),
              Color.fromARGB(234, 255, 65, 65),
            ],
          ),
    duration: Duration(seconds: duration),
  );
}
