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

import '../controllers/register_npwpd_controller.dart';

class RegisterNpwpdView extends GetView<RegisterNpwpdController> {
  const RegisterNpwpdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: CustomAppBar(
        title: "Pendaftaran Akun",
        leading: true,
        isLogin: true,
      ),
      body: GestureDetector(
        onTap: () => dismissKeyboard(),
        child: GetBuilder<RegisterNpwpdController>(
            init: RegisterNpwpdController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  children: [
                    Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Colors.white),
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            TextFields.defaultTextField2(
                                title: "Nama Lengkap Pemilik",
                                controller: controller.nama,
                                isLoading: controller.isLoading,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.name,
                                prefixIcon: Icons.person,
                                borderColor: primaryColor,
                                validator: true,
                                textCapitalization: TextCapitalization.words),
                            TextFields.defaultTextField2(
                              title: "No. HP",
                              controller: controller.no_hp,
                              isLoading: controller.isLoading,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              prefixIcon: Icons.phone_android,
                              borderColor: primaryColor,
                              validator: true,
                            ),
                            TextFields.defaultTextField2(
                              title: "NIK Pemilik",
                              controller: controller.nik,
                              isLoading: controller.isLoading,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              prefixIcon: Icons.contact_emergency,
                              borderColor: primaryColor,
                              validator: true,
                            ),
                            TextFields.defaultTextField2(
                              title: "Password",
                              controller: controller.password,
                              isLoading: controller.isLoading,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              prefixIcon: Icons.key,
                              borderColor: primaryColor,
                              validator: true,
                            ),
                          ],
                        )),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Texts.caption("Telah memiliki NPWPD?", isBold: true),
                          //Field NPWPD 1
                          controller.hidebutton1
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: TextFields.defaultTextField2(
                                        title: "1.NPWPD",
                                        isLoading: controller.isLoading,
                                        textInputAction: TextInputAction.next,
                                        textInputType: TextInputType.name,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        prefixIcon: Icons.pin,
                                        borderColor: primaryColor,
                                        controller: controller.npwpd,
                                        hintText: 'P.1.00XXXXX.03.02',
                                        inputFormatter: [
                                          controller.maskFormatter
                                        ],
                                        validator: false,
                                      ),
                                    ),
                                    Expanded(
                                        // optional flex property if flex is 1 because the default flex is 1
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 2),
                                      child: SizedBox(
                                        width: 70, // <-- Your width
                                        height: 33, // <-- Your height
                                        child: controller.buttoncheck1
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green[300],
                                                ),
                                                onPressed: () {
                                                  dismissKeyboard();
                                                  controller.checknpwpd(
                                                      buttonberapa: "1",
                                                      context: context,
                                                      value: controller.npwpd);
                                                },
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  size: 33.0,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  dismissKeyboard();
                                                  controller.checknpwpd(
                                                      buttonberapa: "1",
                                                      context: context,
                                                      value: controller.npwpd);
                                                },
                                                child: Text(
                                                  "Check NPWPD",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                      ),
                                    )),
                                  ],
                                )
                              : SizedBox.shrink(),
                          //Field NPWPD 2
                          controller.hidebutton2
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: TextFields.defaultTextField2(
                                        title: "2.NPWPD",
                                        isLoading: controller.isLoading,
                                        textInputAction: TextInputAction.next,
                                        textInputType: TextInputType.name,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        prefixIcon: Icons.pin,
                                        borderColor: primaryColor,
                                        controller: controller.npwpd2,
                                        hintText: 'P.1.00XXXXX.03.02',
                                        inputFormatter: [
                                          controller.maskFormatter
                                        ],
                                        validator: false,
                                      ),
                                    ),
                                    Expanded(
                                        // optional flex property if flex is 1 because the default flex is 1
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 2),
                                      child: SizedBox(
                                        width: 70, // <-- Your width
                                        height: 33, // <-- Your height
                                        child: controller.buttoncheck2
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green[300],
                                                ),
                                                onPressed: () {
                                                  dismissKeyboard();
                                                  controller.checknpwpd(
                                                      buttonberapa: "2",
                                                      context: context,
                                                      value: controller.npwpd2);
                                                },
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  size: 33.0,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  dismissKeyboard();
                                                  controller.checknpwpd(
                                                      buttonberapa: "2",
                                                      context: context,
                                                      value: controller.npwpd2);
                                                },
                                                child: Text(
                                                  "Check NPWPD",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                      ),
                                    )),
                                  ],
                                )
                              : SizedBox.shrink(),
                          //Field NPWPD 3
                          controller.hidebutton3
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: TextFields.defaultTextField2(
                                        title: "3.NPWPD",
                                        isLoading: controller.isLoading,
                                        textInputAction: TextInputAction.next,
                                        textInputType: TextInputType.name,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        prefixIcon: Icons.pin,
                                        borderColor: primaryColor,
                                        controller: controller.npwpd3,
                                        hintText: 'P.1.00XXXXX.03.02',
                                        inputFormatter: [
                                          controller.maskFormatter
                                        ],
                                        validator: false,
                                      ),
                                    ),
                                    Expanded(
                                        // optional flex property if flex is 1 because the default flex is 1
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12, left: 2),
                                      child: SizedBox(
                                        width: 70, // <-- Your width
                                        height: 33, // <-- Your height
                                        child: controller.buttoncheck3
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green[300],
                                                ),
                                                onPressed: () {
                                                  dismissKeyboard();
                                                  controller.checknpwpd(
                                                      buttonberapa: "3",
                                                      context: context,
                                                      value: controller.npwpd3);
                                                },
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_outlined,
                                                  size: 33.0,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  dismissKeyboard();
                                                  controller.checknpwpd(
                                                      buttonberapa: "3",
                                                      context: context,
                                                      value: controller.npwpd3);
                                                },
                                                child: Text(
                                                  "Check NPWPD ",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                      ),
                                    )),
                                  ],
                                )
                              : SizedBox.shrink(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.btntambah();
                                },
                                child: Text(
                                  "Tambah NPWPD",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 223, 223, 223),
                                    onPrimary: Color.fromARGB(221, 57, 57, 57),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 11),
                                    textStyle: TextStyle(fontSize: 30)),
                              ),
                              controller.hidebutton1 == false &&
                                      controller.hidebutton2 == false &&
                                      controller.hidebutton3 == false
                                  ? SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.btnX();
                                        },
                                        child: Text(
                                          "X",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            onPrimary: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 11, vertical: 4),
                                            textStyle: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Buttons.gradientButton(
                            handler: () {
                              easyThrottle(
                                  handler: () => controller.saveData());
                            },
                            widget: Texts.button("Daftar"),
                            borderSide: false,
                            gradient: [Colors.cyan, Colors.indigo],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
