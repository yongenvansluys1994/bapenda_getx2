import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/badge_notif.dart';
import 'package:bapenda_getx2/widgets/custtombottombar.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2/app/modules/dashboard/services/dashboard_services.dart';
import 'package:bapenda_getx2/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Dashboard extends StatelessWidget {
  final DashboardController controller = Get.find();
  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(DashboardServices(
        Get.find<Api>(),
      )),
      builder: (controller) {
        return Scaffold(
            extendBodyBehindAppBar: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Image.asset(
                "assets/images/appbar-bapenda.png",
                height: 68,
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: lightColor,
                        border: Border.all(width: 2.w, color: shadowColor2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.bars,
                          color: primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ),
                    ),
                  );
                },
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: lightColor,
                      border: Border.all(width: 2.w, color: shadowColor2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: primaryColor,
                      ),
                      tooltip: "Open notifications menu",
                      onPressed: () => Get.toNamed(Routes.DASHBOARD),
                    ),
                  ),
                ),
              ],
            ),
            drawer: buildDrawer(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Selamat Datang, ${controller.authModel.nama}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: MainColor),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150.h,
                          decoration: BoxDecoration(
                              // border: Border.all(
                              //     color: Colors.black12.withOpacity(0.04)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.sp),
                                  topLeft: Radius.circular(8.sp),
                                  bottomLeft: Radius.circular(8.sp),
                                  bottomRight: Radius.circular(8.sp)),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/dashboard_1.png"),
                                  fit: BoxFit.fill),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 195, 226, 254)
                                        .withOpacity(0.6),
                                    offset: Offset(5, 5),
                                    blurRadius: 7,
                                    spreadRadius: 2.0),
                                BoxShadow(
                                    color: Color.fromARGB(159, 232, 232, 232),
                                    offset: Offset(-5, -5),
                                    blurRadius: 7,
                                    spreadRadius: 2.0)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 77.h,
                                      width: 180.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Periode Pajak Terutang',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: MainColor,
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          // Padding(
                                          //   padding:
                                          //       EdgeInsetsDirectional.fromSTEB(
                                          //           0, 4, 0, 0),
                                          //   child: Text(
                                          //     'Hotel Akbar - September 2023',
                                          //     style: TextStyle(
                                          //       fontFamily: 'Plus Jakarta Sans',
                                          //       color: Color(0xFF57636C),
                                          //       fontSize: 10.sp,
                                          //       fontWeight: FontWeight.w500,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 85.h,
                                      width: 2.3.h,
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      height: 85.h,
                                      width: 95.w,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Kepatuhan Pajak',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              height: 53.h,
                                              child: SleekCircularSlider(
                                                appearance:
                                                    CircularSliderAppearance(
                                                        customColors:
                                                            CustomSliderColors(
                                                                progressBarColors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  63,
                                                                  211,
                                                                  193),
                                                              Color.fromARGB(
                                                                  255,
                                                                  54,
                                                                  240,
                                                                  218),
                                                              Color.fromARGB(
                                                                  255,
                                                                  203,
                                                                  251,
                                                                  246),
                                                            ]),
                                                        infoProperties: InfoProperties(
                                                            mainLabelStyle:
                                                                TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            0,
                                                                            255,
                                                                            193,
                                                                            7))),
                                                        spinnerMode: false,
                                                        angleRange: 360,
                                                        size: 172,
                                                        customWidths:
                                                            CustomSliderWidths(
                                                                progressBarWidth:
                                                                    5)),
                                                min: 0,
                                                max: 100,
                                                initialValue: 90,
                                                innerWidget: (double value) =>
                                                    Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "100 %",
                                                        style: TextStyle(
                                                            fontSize: 9.sp,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 30.sp,
                                      height: 30.sp,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF39D2C0),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x2B202529),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                      ),
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: controller.datalist.length == 0
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : Text(
                                              '${controller.datalist.length}',
                                              style: TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            7, 0, 0, 0),
                                        child: Text(
                                          controller.datalist.length == 0
                                              ? 'Tidak ada Invoice Pembayaran'
                                              : 'Invoice Menunggu Pembayaran',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: MainColor,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
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
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: MainColor,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.r),
                        height: 220.h,
                        decoration: BoxDecoration(
                          // color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: (9 / 10),
                          crossAxisCount: 4,
                          padding: EdgeInsets.only(top: 2.h),
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      notif(
                                          showbadge:
                                              controller.tot_pelaporan == 0
                                                  ? false
                                                  : true,
                                          number: controller.tot_pelaporan),
                                      Ink(
                                        height: 63.h,
                                        width: 62.w,
                                        decoration: BoxDecoration(
                                          gradient:
                                              LinearGradient(colors: <Color>[
                                            Color.fromARGB(255, 235, 237, 244),
                                            Color.fromARGB(255, 188, 230, 236)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(8.w),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(3, 3),
                                                spreadRadius: 1),
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 4,
                                                offset: Offset(-1, -1),
                                                spreadRadius: 1),
                                          ],
                                        ),
                                        child: InkWell(
                                          splashColor: lightBlueColor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/pelaporan.png'))),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            Get.toNamed(Routes.LAPOR_PAJAK,
                                                arguments:
                                                    controller.authModel);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("Lapor Pajak",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Ink(
                                    height: 63.h,
                                    width: 62.w,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        Color.fromARGB(255, 235, 237, 244),
                                        Color.fromARGB(255, 188, 230, 236)
                                      ]),
                                      borderRadius: BorderRadius.circular(8.w),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(3, 3),
                                            spreadRadius: 1),
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 4,
                                            offset: Offset(-1, -1),
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: InkWell(
                                      splashColor: lightBlueColor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 44.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/cek_nop.png'))),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        getDefaultDialog().onFix(
                                            title: "Mohon Maaf",
                                            desc:
                                                "Modul Pelayanan PBB sedang dalam pengembangan",
                                            kategori: "error");
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("PBB",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Ink(
                                    height: 63.h,
                                    width: 62.w,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        Color.fromARGB(255, 235, 237, 244),
                                        Color.fromARGB(255, 188, 230, 236)
                                      ]),
                                      borderRadius: BorderRadius.circular(8.w),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(3, 3),
                                            spreadRadius: 1),
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 4,
                                            offset: Offset(-2, -2),
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: InkWell(
                                      splashColor: lightBlueColor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 35.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/ppid.png'))),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Get.toNamed(Routes.PPID,
                                            arguments: controller.authModel);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("PPID",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Ink(
                                    height: 63.h,
                                    width: 62.w,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        Color.fromARGB(255, 235, 237, 244),
                                        Color.fromARGB(255, 188, 230, 236)
                                      ]),
                                      borderRadius: BorderRadius.circular(8.w),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(3, 3),
                                            spreadRadius: 1),
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 4,
                                            offset: Offset(-1, -1),
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: InkWell(
                                      splashColor: lightBlueColor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 39.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/map.png'))),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Get.toNamed(Routes.LOKASI_KANTOR,
                                            arguments: controller.authModel);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("Lokasi Kantor",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      notif(
                                          showbadge:
                                              controller.datalist.length == 0
                                                  ? false
                                                  : true,
                                          number: controller.datalist.length),
                                      Ink(
                                        height: 63.h,
                                        width: 62.w,
                                        decoration: BoxDecoration(
                                          gradient:
                                              LinearGradient(colors: <Color>[
                                            Color.fromARGB(255, 235, 237, 244),
                                            Color.fromARGB(255, 188, 230, 236)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(8.w),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(3, 3),
                                                spreadRadius: 1),
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 4,
                                                offset: Offset(-1, -1),
                                                spreadRadius: 1),
                                          ],
                                        ),
                                        child: InkWell(
                                          splashColor: lightBlueColor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/pembayaran.png'))),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            Get.toNamed(Routes.PEMBAYARAN,
                                                arguments:
                                                    controller.authModel);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("Pembayaran",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center),

                                  // Expanded(child: notifkhotbah()),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Ink(
                                    height: 63.h,
                                    width: 62.w,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        Color.fromARGB(255, 235, 237, 244),
                                        Color.fromARGB(255, 188, 230, 236)
                                      ]),
                                      borderRadius: BorderRadius.circular(8.w),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(3, 3),
                                            spreadRadius: 1),
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 4,
                                            offset: Offset(-1, -1),
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: InkWell(
                                      splashColor: lightBlueColor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/images/panduan.png",
                                              fit: BoxFit.contain,
                                              width: 36.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Get.toNamed(Routes.PANDUAN,
                                            arguments: controller.authModel);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("Panduan",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center)
                                  // Expanded(child: notif()),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      notif(
                                          showbadge:
                                              controller.countUnseenChat == 0
                                                  ? false
                                                  : true,
                                          number: controller.countUnseenChat
                                              .toInt()),
                                      Ink(
                                        height: 63.h,
                                        width: 62.w,
                                        decoration: BoxDecoration(
                                          gradient:
                                              LinearGradient(colors: <Color>[
                                            Color.fromARGB(255, 235, 237, 244),
                                            Color.fromARGB(255, 188, 230, 236)
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(8.w),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(3, 3),
                                                spreadRadius: 1),
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 4,
                                                offset: Offset(-1, -1),
                                                spreadRadius: 1),
                                          ],
                                        ),
                                        child: InkWell(
                                          splashColor: lightBlueColor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/tanya.png'))),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            Get.toNamed(Routes.CHAT,
                                                arguments:
                                                    controller.authModel);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("Chat Admin",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center,
                                      maxLines: 2),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Ink(
                                    height: 63.h,
                                    width: 62.w,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: <Color>[
                                        Color.fromARGB(255, 235, 237, 244),
                                        Color.fromARGB(255, 188, 230, 236)
                                      ]),
                                      borderRadius: BorderRadius.circular(8.w),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(3, 3),
                                            spreadRadius: 1),
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 4,
                                            offset: Offset(-1, -1),
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: InkWell(
                                      splashColor: lightBlueColor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/faq.png'))),
                                          ),
                                        ],
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                  SizedBox(height: 9.h),
                                  Texts.captionDashboard("FAQ",
                                      color: lightTextColor,
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 22.r),
                              child: Texts.caption("Terbaru di Bapenda",
                                  color: MainColor, isBold: true)),
                          InkWell(
                            splashColor: lightBlueColor,
                            onTap: () {},
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Lihat Semua",
                                    style: TextStyle(
                                        fontSize: 12.sp, color: textLink),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      GetBuilder<DashboardController>(
                        init: DashboardController(DashboardServices(
                          Get.find<Api>(),
                        )),
                        builder: (controller) {
                          if (controller.isLoadingAds) {
                            return ShimmerWidget.Items1();
                          }

                          if (controller.datalistAds.isEmpty) {
                            return ShimmerWidget.Items1();
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.r),
                            child: SizedBox(
                              height: 145.h,
                              width: 500.w,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.datalistAds.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(2),
                                  itemBuilder: (context, index) {
                                    var dataitem =
                                        controller.datalistAds[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.ADS_DETAIL,
                                            arguments: dataitem);
                                      },
                                      child: Container(
                                        width: 170.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://yongen-bisa.com/bapenda_app/upload/${dataitem.urlImage}", // "${URL_APP}/upload/${dataitem.urlImage}",
                                                height: 100.h,
                                                width: 160.w,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    ShimmerWidget.rectangular(
                                                  height: 100.h,
                                                  width: 160.w,
                                                  baseColor: shadowColor,
                                                ),
                                                errorWidget:
                                                    ((context, url, error) =>
                                                        Image.asset(
                                                          'images/image.png',
                                                          fit: BoxFit.cover,
                                                          height: 100.h,
                                                          width: 160.w,
                                                        )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Texts.captionSm(
                                              "${dataitem.judul}", //${dataitem.judul}
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 22.r),
                              child: Texts.caption("PPID",
                                  color: MainColor, isBold: true)),
                          InkWell(
                            splashColor: lightBlueColor,
                            onTap: () {},
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Lihat Semua",
                                    style: TextStyle(
                                        fontSize: 12.sp, color: textLink),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      GetBuilder<DashboardController>(
                        init: DashboardController(DashboardServices(
                          Get.find<Api>(),
                        )),
                        builder: (controller) {
                          if (controller.isLoadingPPID) {
                            return ShimmerWidget.Items1();
                          }

                          if (controller.datalistPPID.isEmpty) {
                            return ShimmerWidget.Items1();
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.r),
                            child: SizedBox(
                              height: 145.h,
                              width: 500.w,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.datalistPPID.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(2),
                                  itemBuilder: (context, index) {
                                    var dataitem =
                                        controller.datalistPPID[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.ADS_DETAIL,
                                            arguments: dataitem);
                                      },
                                      child: Container(
                                        width: 170.w,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "https://cdn.pixabay.com/photo/2014/12/02/08/09/info-553635_1280.jpg", // "${URL_APP}/upload/${dataitem.urlImage}",
                                                height: 100.h,
                                                width: 160.w,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    ShimmerWidget.rectangular(
                                                  height: 100.h,
                                                  width: 160.w,
                                                  baseColor: shadowColor,
                                                ),
                                                errorWidget:
                                                    ((context, url, error) =>
                                                        Image.asset(
                                                          'images/image.png',
                                                          fit: BoxFit.cover,
                                                          height: 100.h,
                                                          width: 160.w,
                                                        )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Texts.captionSm(
                                              "Promosi Usaha Wajib Pajak", //${dataitem.judul}
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 22.r),
                              child: Texts.caption("Aplikasi Lainnya",
                                  color: MainColor, isBold: true)),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        child: SizedBox(
                            height: 155.h,
                            width: 500.w,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(2),
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.PARKIR_APP,
                                        arguments: controller.authModel);
                                  },
                                  child: Container(
                                    width: 170.w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.w),
                                            child: Image.asset(
                                                "assets/images/parkirapp.jpg")),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Texts.captionSm(
                                          "Aplikasi Parkir by Bapenda", //${dataitem.judul}
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: customButtomBar());
      },
    );
  }
}
