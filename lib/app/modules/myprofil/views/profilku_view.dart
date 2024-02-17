import 'package:bapenda_getx2/app/modules/myprofil/controllers/myprofil_controller.dart';
import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfilkuView extends GetView<MyprofilController> {
  const ProfilkuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profil Saya",
        leading: true,
        isLogin: true,
      ),
      body: Column(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  height: MediaQuery.of(context).size.height / 4.3,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/header-top.png'),
                ),
                Positioned(
                    bottom: -50.0,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                            'assets/icon/${controller.authModel.foto}'),
                        backgroundColor: Colors.transparent,
                      ),
                    ))
              ]),
          SizedBox(
            height: 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Nama",
                    labelStyle: TextStyle(
                        color: lightGreenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: lightGreenColor),
                    ),
                  ),
                  initialValue: "${controller.authModel.nama}",
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "NIK",
                    labelStyle: TextStyle(
                        color: lightGreenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: lightGreenColor),
                    ),
                  ),
                  initialValue: "${controller.authModel.nik}",
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Nomor HP",
                    labelStyle: TextStyle(
                        color: lightGreenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: lightGreenColor),
                    ),
                  ),
                  initialValue: "${controller.authModel.noHp}",
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: textColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () async {
                controller.dashboardController.logout();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18),
                ),
              )),
        ],
      ),
    );
  }
}
