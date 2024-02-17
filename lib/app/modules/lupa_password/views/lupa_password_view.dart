import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/easythrottle.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  const LupaPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dismissKeyboard();
      },
      child: Scaffold(
        appBar:
            CustomAppBar(title: "Lupa Password", leading: true, isLogin: true),
        body: GetBuilder<LupaPasswordController>(
          init: LupaPasswordController(),
          builder: (controller) {
            return Form(
              key: controller.formKey,
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.r),
                      child: Texts.body2(
                          "Masukkan No.HP & NIK sesuai saat pendaftaran Akun",
                          textAlign: TextAlign.center,
                          maxLines: 3),
                    ),
                    TextFields.defaultTextField2(
                        readOnly:
                            controller.buttonKirim == false ? true : false,
                        title: "NIK Pemilik",
                        hintText: "6474xxxxxxxxxxxx",
                        controller: controller.nik,
                        isLoading: controller.isLoading,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        prefixIcon: Icons.person,
                        borderColor: primaryColor,
                        validator: true,
                        textCapitalization: TextCapitalization.words),
                    TextFields.defaultTextField2(
                      readOnly: controller.buttonKirim == false ? true : false,
                      title: "No. HP",
                      hintText: "0812xxxxxxxx",
                      controller: controller.no_hp,
                      isLoading: controller.isLoading,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      prefixIcon: Icons.phone_android,
                      borderColor: primaryColor,
                      validator: true,
                    ),
                    SizedBox(height: 10.h),
                    Buttons.gradientButton(
                      handler: () {
                        controller.buttonKirim == false
                            ? null
                            : easyThrottle(handler: () {
                                controller.lupaPassword();
                              });
                      },
                      widget: Texts.button("Kirim"),
                      borderSide: false,
                      gradient: [
                        controller.buttonKirim == false
                            ? Colors.grey
                            : Colors.cyan,
                        controller.buttonKirim == false
                            ? Colors.grey
                            : Colors.indigo
                      ],
                    ),
                    SizedBox(height: 20.h),
                    controller.show_newPassword == true
                        ? TextFields.defaultTextField2(
                            title: "Password Baru",
                            isLoading: controller.isLoading,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            prefixIcon: Icons.key,
                            controller: controller.newPassword,
                            borderColor: primaryColor,
                            validator: true,
                          )
                        : SizedBox(),
                    SizedBox(height: 10.h),
                    controller.show_newPassword == true
                        ? Buttons.gradientButton(
                            handler: () {
                              easyThrottle(handler: () {
                                controller.simpanNewPassword();
                              });
                            },
                            widget: Texts.button("Simpan Password Baru"),
                            borderSide: false,
                            gradient: [Colors.cyan, Colors.indigo],
                          )
                        : SizedBox()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
