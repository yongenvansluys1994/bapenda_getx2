import 'package:bapenda_getx2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class customButtomBar extends StatelessWidget {
  const customButtomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: Get.width * 0.2,
                  onPressed: () {
                    Get.currentRoute == Routes.DASHBOARD
                        ? null
                        : Get.toNamed(Routes.DASHBOARD);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.dashboard,
                        color: Get.currentRoute == Routes.DASHBOARD
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      Text(
                        'Beranda',
                        style: TextStyle(
                          color: Get.currentRoute == Routes.DASHBOARD
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: Get.width * 0.2,
                  onPressed: () {
                    Get.currentRoute == Routes.KARTUNPWPD
                        ? null
                        : Get.toNamed(Routes.KARTUNPWPD,
                            arguments: controller.authModel);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.quick_contacts_mail_rounded,
                          color: Get.currentRoute == Routes.KARTUNPWPD
                              ? Colors.blue
                              : Colors.grey),
                      Text(
                        "Kartu NPWPD",
                        style: TextStyle(
                          color: Get.currentRoute == Routes.KARTUNPWPD
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: Get.width * 0.2,
                  onPressed: () {
                    Get.currentRoute == Routes.MYPROFIL
                        ? null
                        : Get.toNamed(Routes.MYPROFIL,
                            arguments: controller.authModel);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        color: Get.currentRoute == Routes.MYPROFIL
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      Text(
                        'Profil',
                        style: TextStyle(
                          color: Get.currentRoute == Routes.MYPROFIL
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: Get.width * 0.2,
                  onPressed: () {
                    Get.currentRoute == Routes.OBJEKKU
                        ? null
                        : Get.toNamed(Routes.OBJEKKU,
                            arguments: controller.authModel);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.chat,
                        color: Get.currentRoute == Routes.OBJEKKU
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      Text(
                        'Objek-Ku',
                        style: TextStyle(
                          color: Get.currentRoute == Routes.OBJEKKU
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
