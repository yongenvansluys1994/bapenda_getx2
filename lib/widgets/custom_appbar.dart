import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool leading;
  CustomAppBar(
      {required this.title, required this.leading, required bool isLogin});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Texts.appBarText(title, color: MainColor),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      // flexibleSpace: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: <Color>[Color.fromARGB(255, 23, 48, 187), Colors.cyan],
      //     ),
      //   ),
      // ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: lightColor,
              border: Border.all(width: 2.w, color: shadowColor2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
                color: primaryColor,
              ),
              tooltip: "Open notifications menu",
              onPressed: () {},
            ),
          ),
        ),
      ],
      leading: leading == true
          ? Padding(
              padding: EdgeInsets.only(
                  top: 5.h, bottom: 5.h, left: 6.w, right: 3.7.w),
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: lightColor,
                  border: Border.all(width: 2.w, color: shadowColor2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: primaryColor,
                  ),
                  tooltip: "Open notifications menu",
                  onPressed: () {
                    Get.back();
                    //Get.offNamed(Routes.DASHBOARD);
                  },
                ),
              ),
            )
          : SizedBox(),

      // actions: menuWidget != null ? [menuWidget] : null,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
