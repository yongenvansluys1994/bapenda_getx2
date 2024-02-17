import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bapenda_getx2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class MainDrawer extends StatelessWidget {
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('asdasdas'),
                    accountEmail: Text('asd'),
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                  ListTile(
                    title: Text('Home'),
                    tileColor: Get.currentRoute == Routes.DASHBOARD
                        ? Colors.grey[300]
                        : null,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

buildDrawer() {
  DashboardController controller = Get.find();
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: Get.width.w,
            alignment: Alignment.bottomLeft,
            decoration: const BoxDecoration(
              color: appBarColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.r),
                      border: Border.all(color: shadowColor, width: 2),
                    ),
                    child: ClipRRect(
                        child: Image.asset(
                      "assets/icon/${controller.authModel.foto}",
                      height: 40.h,
                      width: 40.w,
                      fit: BoxFit.cover,
                    )),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Texts.body2(
                          '${controller.authModel.nama}',
                          textAlign: TextAlign.left,
                        ),
                        Texts.caption(
                          '${controller.authModel.nik}',
                          textAlign: TextAlign.left,
                          color: shadowColor,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 30.sp,
                      height: 30.sp,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x2B202529),
                            offset: Offset(0, 2),
                          )
                        ],
                        shape: BoxShape.circle,
                      ),
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Icon(
                        Icons.close,
                        color: MainColor,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              color: primaryColor,
              child: ListTile(
                onTap: () {
                  Get.offAndToNamed(Routes.MYPROFIL,
                      arguments: controller.authModel);
                },
                leading: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: appBarColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: primaryColor,
                      size: 15,
                    ),
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: primaryColor,
                  size: 15,
                ),
                title: Texts.caption(
                  'Profil',
                  color: primaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              color: primaryColor,
              child: Stack(
                children: [
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.ADSPAGE,
                          arguments: controller.authModel);
                    },
                    leading: Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: appBarColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.shop,
                          color: primaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      color: primaryColor,
                      size: 15,
                    ),
                    title: Texts.caption(
                      'Promosi & Iklan',
                      color: primaryColor,
                    ),
                  ),
                  Positioned(
                    right: 8.r,
                    child: badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.square,
                          badgeColor: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      badgeContent: Text(' Baru ',
                          style: TextStyle(
                              color: Colors.white, fontSize: 10.5.sp)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.sp),
            child: const Divider(),
          ),
          Padding(
            padding: EdgeInsets.all(5.sp),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ListTile(
                onTap: () {
                  controller.logout();
                },
                leading: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    color: appBarColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Transform.scale(
                      scaleX: -1,
                      child: const Icon(
                        FontAwesomeIcons.rightFromBracket,
                        color: primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: primaryColor,
                  size: 15,
                ),
                title: Texts.caption(
                  "Log Out",
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
