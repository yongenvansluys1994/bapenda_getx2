import 'dart:developer';

import 'package:bapenda_getx2/app/modules/auth/dto/user_model.dart';
import 'package:bapenda_getx2/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2/app/modules/auth/service/auth_via_db_service.dart';
import 'package:bapenda_getx2/app/modules/auth/service/employee_service.dart';
import 'package:bapenda_getx2/app/modules/login/services/login_services.dart';
import 'package:bapenda_getx2/utils/app_const.dart';

import 'package:carousel_slider/carousel_controller.dart';

import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:bapenda_getx2/widgets/utils/controllers/textfield_controller.dart';
import 'package:bapenda_getx2/widgets/utils/debouncer.dart';
import 'package:bapenda_getx2/widgets/utils/validator_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class LoginController extends GetxController with AuthCacheService {
  TextFieldController usernameTextField = TextFieldController.emptyController();
  TextFieldController passwordTextField = TextFieldController.emptyController();
  CarouselController carouselController = CarouselController();
  final AuthViaDBService _authViaDBService = AuthViaDBService();
  final fetchingState = false.obs;
  var isObscure = true.obs;
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  int activeIndex = 0;
  int carouselCount = 3;
  bool isLoading = false;
  bool isActive = false;
  late String tokenMsg;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final EmployeeService employeeService = EmployeeService();
  LoginServices services;
  LoginController(this.services);

  void setFetchingState(bool status) {
    fetchingState.value = status;
  }

  buildCarousel() {
    return SizedBox(
      height: Get.height.h,
      width: Get.width.w,
      child: ListView(
        padding: EdgeInsets.all(16.sp),
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(15.r), // Adjust the radius as needed
            child: Image.asset(
              'assets/images/login-char.jpg',
              fit: BoxFit.cover,
              // width: 100, // Adjust the width as needed
              // height: 100, // Adjust the height as needed
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Texts.body1(
              "Channel Pembayaran VA & QRIS",
              textAlign: TextAlign.center,
              color: const Color(0XFF006298),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Texts.body2(
              "Bapenda Etam kini telah tersedia Channel Pembayaran Virtual Account & QRIS. Untuk memudahkan anda dalam melakukan pembayaran Pajak Daerah",
              textAlign: TextAlign.center,
              color: shadowColor,
              textOverflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  // buildCarousel2() {
  //   return SizedBox(
  //     height: Get.height.h,
  //     width: Get.width.w,
  //     child: ListView(
  //       padding: EdgeInsets.all(16.sp),
  //       children: [
  //         ClipRRect(
  //           borderRadius:
  //               BorderRadius.circular(15.r), // Adjust the radius as needed
  //           child: Image.asset(
  //             'assets/images/login-char2.jpg',
  //             fit: BoxFit.cover,
  //             // width: 100, // Adjust the width as needed
  //             // height: 100, // Adjust the height as needed
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.symmetric(vertical: 8.h),
  //           child: Texts.body1(
  //               "Jatuh Tempo Pembayaran PBB Thn 2023 di Perpanjang!",
  //               textAlign: TextAlign.center,
  //               color: const Color(0XFF006298),
  //               maxLines: 2),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.symmetric(vertical: 8.h),
  //           child: Texts.body2(
  //             "Jatuh Tempo Pembayaran PBB 2023 di perpanjang sampai 24 Desember 2023, Ayo Manfaatkan Waktu Bayar PBB Tahun 2023 tanpa Denda.",
  //             textAlign: TextAlign.center,
  //             color: shadowColor,
  //             textOverflow: TextOverflow.visible,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  changeCarouselIndicator(index, reason) {
    activeIndex = index;
    update();
  }

  login() async {
    if (usernameTextField.text.isNotEmpty ||
        passwordTextField.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      EasyLoading.show(status: 'loading...');
      update();
      setFetchingState(true);

      try {
        var result = await _authViaDBService.login(
            usernameTextField.text, passwordTextField.text);

        // Handle the result here, for example:
        if (result['success'] == true) {
          setFetchingState(true);
          User userInfo = await employeeService.getUser(usernameTextField.text);

          final box = GetStorage();
          box.write(STORAGE_LOGIN_USER_DATA, {
            "id_userwp": userInfo.idUserwp,
            "nama": userInfo.nama,
            "nik": userInfo.nik,
            "no_hp": userInfo.noHp,
            "password": userInfo.password,
            "foto": userInfo.foto,
            "last_active": "123"
          });
          setFetchingState(false);

          if (APP_MODE == "prod") {
            setFetchingState(true);
            await getTokenMsg(
                userInfo.nik, userInfo.noHp, userInfo.foto, userInfo.nama);
            await InsertTokenFcm(userInfo.nik, tokenMsg);
            setFetchingState(false);
          }

          log("Logged in as ${userInfo.nama}");

          EasyLoading.dismiss();

          Get.offAllNamed(Routes.DASHBOARD, arguments: "login");
          // getDefaultDialog().onFixWithoutIcon(
          //     title: "Selamat Datang",
          //     desc:
          //         "Nikmati fitur-fitur terbaru pada Big Update Bapenda Etam");
          update();
        } else {
          EasyLoading.dismiss();
          // User authentication failed
          // Handle the error message, e.g., display an error message to the user
          print("Authentication failed: ${result['message']}");
        }
      } catch (error) {
        // Handle any exceptions that may be thrown
        print("An error occurred: $error");
      }
      setFetchingState(false);
      //await saveRefreshToken(keycloakService.refreshToken);
    } else {
      usernameTextField.checkValid();
      passwordTextField.checkValid();
      update();
    }
  }

  void LoginAkses_RT() {
    final box = GetStorage();
    box.write(STORAGE_LOGIN_USER_DATA, {
      "id_userwp": '2', //id_userwp default ketua adalah 2
      "nama": 'Ketua RT',
      "nik": 'ketuart',
      "no_hp": 'ketuart',
      "password": 'ketuart',
      "foto": 'user_6.png',
      "last_active": "123"
    });
    Get.offAllNamed(Routes.DASHBOARD, arguments: "login");
  }

  @override
  void onInit() {
    super.onInit();
    usernameTextField = TextFieldController(
      "",
      [Validators.notEmpty],
      "Nomor pegawai is not valid",
      update,
      debouncer,
    );
    passwordTextField = TextFieldController(
      "",
      [Validators.password],
      "Password is not valid",
      update,
      debouncer,
      obscureText: true,
    );
  }

  InsertTokenFcm(String nik, String token) {
    update();
    services.token_fcm({
      'nik': nik,
      'token': token,
    }).then(
      (value) async {
        print("Sukses Perbaharui Token");
      },
    ).catchError(
      (e) {
        print("Gagal");
      },
    ).then(
      (value) {
        update();
      },
    );
  }

  Future getTokenMsg(String nik, String noHp, String foto, String nama) async {
    await FirebaseMessaging.instance.getToken().then((token) {
      tokenMsg = token!;

      print(tokenMsg);
      print(nik);
      saveTokenMsg(token, nik, noHp, foto, nama);
    });
  }

  Future saveTokenMsg(
      String token, String nik, String noHp, String foto, String nama) async {
    await FirebaseFirestore.instance.collection("UserTokens").doc(nik).set({
      'token': token,
      'image': foto,
      'nama': nama,
    });
    FirebaseMessaging.instance.subscribeToTopic("user");
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  PilihPendaftaran(BuildContext context) {
    Alert(
            context: context,
            content: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 115.w,
                      height: 115.h,
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
                          onTap: () {
                            Get.toNamed(Routes.REGISTER_NPWPD);
                            update();
                          },
                          splashColor: primaryColor,
                          splashFactory: InkSplash.splashFactory,
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/icon-npwpd.png",
                                  width: 70.w,
                                  height: 70.h,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  'Sudah Memiliki NPWPD',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 115.w,
                      height: 115.h,
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
                          onTap: () {
                            Get.toNamed(Routes.REGISTER_BARU);
                            update();
                          },
                          splashColor: primaryColor,
                          splashFactory: InkSplash.splashFactory,
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/icon-nonnpwpd.png",
                                  width: 70.w,
                                  height: 70.h,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  'Daftar Baru Wajib Pajak',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
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
            ),
            style: AlertStyle(
                isButtonVisible: false, animationType: AnimationType.grow))
        .show();
  }
}
