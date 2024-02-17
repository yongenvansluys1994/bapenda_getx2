import 'package:bapenda_getx2/widgets/buttons.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/text_fields.dart';
import 'package:bapenda_getx2/widgets/texts.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_baru_controller.dart';

class RegisterBaruView extends GetView<RegisterBaruController> {
  const RegisterBaruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: CustomAppBar(
        title: "Pendaftaran",
        leading: true,
        isLogin: true,
      ),
      body: GestureDetector(
        onTap: () => dismissKeyboard(),
        child: GetBuilder<RegisterBaruController>(
            init: RegisterBaruController(),
            builder: (controller) {
              return Form(
                key: controller.formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Column(
                          children: [
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
                    Texts.caption(
                        "*Anda harus mengingat Password ini untuk Login kedalam Aplikasi",
                        maxLines: 2,
                        color: const Color.fromARGB(197, 0, 0, 0)),
                    Divider(),
                    SizedBox(height: 20),
                    Buttons.gradientButton(
                      handler: () => controller.saveData(),
                      widget: Texts.button("Simpan"),
                      borderSide: false,
                      gradient: [Colors.cyan, Colors.indigo],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
