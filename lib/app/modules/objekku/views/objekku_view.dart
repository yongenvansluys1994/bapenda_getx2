import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/custtombottombar.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/objekku_controller.dart';

class ObjekkuView extends GetView<ObjekkuController> {
  const ObjekkuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Data Objek Pajak",
          leading: true,
          isLogin: true,
        ),
        body: const Center(
          child: Text(
            'ObjekkuView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Container(
        //     width: 60.w,
        //     height: 60.h,
        //     child: Icon(
        //       Icons.add,
        //       size: 40,
        //     ),
        //     decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         gradient: LinearGradient(colors: gradientColor)),
        //   ),
        //   onPressed: () {},
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: customButtomBar());
  }
}
