import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/login/services/login_services.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bapenda_getx2/app/modules/login/controllers/login_controller.dart';
import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(LoginServices(
        Get.find<Api>(),
      )),
      builder: (controller) {
        return Scaffold(
          body: GestureDetector(
            onTap: () => dismissKeyboard(),
            child: ListView(
              children: [
                Container(
                  height: Get.height.h / 2,
                  width: Get.width.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CarouselSlider.builder(
                        itemCount: controller.carouselCount,
                        itemBuilder: (context, index, realIndex) {
                          if (index == 0) {
                            return controller.buildCarousel();
                          } else if (index == 1) {
                            return controller.buildCarousel();
                          } else if (index == 2) {
                            return controller.buildCarousel();
                          } else {
                            // Return a default item or an empty container
                            return controller.buildCarousel();
                          }
                        },
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          scrollPhysics: const ClampingScrollPhysics(),
                          enableInfiniteScroll: false,
                          autoPlayInterval: const Duration(seconds: 10),
                          aspectRatio: Get.height.w / Get.height.h,
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) =>
                              controller.changeCarouselIndicator(index, reason),
                        ),
                        carouselController: controller.carouselController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.carouselCount,
                          (index) {
                            controller.isActive =
                                index == controller.activeIndex;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: controller.isActive
                                      ? const Color(0XFF006298)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: const Color(0XFF006298),
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.sp),
                  height: Get.height / 2,
                  width: Get.width.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 228, 247, 255),
                      Color.fromARGB(255, 238, 253, 247)
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(28.r)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Texts.headline6(
                        "Selamat Datang",
                        textAlign: TextAlign.center,
                        isBold: true,
                      ),
                      Texts.body2(
                        "Masuk ke akun anda",
                        textAlign: TextAlign.center,
                      ),
                      TextFields.defaultTextField(
                        title: "NIK",
                        isLoading: controller.isLoading,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        prefixIcon: Icons.person,
                        textFieldController: controller.usernameTextField,
                        borderColor: primaryColor,
                      ),
                      TextFields.defaultTextField(
                        title: "Password",
                        isLoading: controller.isLoading,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        prefixIcon: Icons.key,
                        textFieldController: controller.passwordTextField,
                        borderColor: primaryColor,
                      ),
                      Buttons.gradientButton(
                        handler: () => controller.login(),
                        widget: Texts.button("Login"),
                        borderSide: false,
                        gradient: [Colors.cyan, Colors.indigo],
                      ),
                      SizedBox(height: 1.h),
                      Buttons.defaultButton(
                        handler: () {
                          Get.toNamed(Routes.REGISTER_NPWPD);
                        },
                        widget: Texts.button("Daftar"),
                        borderSide: false,
                        fillColor: lightTextColor,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.LUPA_PASSWORD);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(7.r),
                          child: Text(
                            "Lupa Password?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.sp,
                                decoration: TextDecoration.underline,
                                color: textLink),
                          ),
                        ),
                      ),
                      Texts.caption(
                        "Application Version 1.${currentversion})",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
