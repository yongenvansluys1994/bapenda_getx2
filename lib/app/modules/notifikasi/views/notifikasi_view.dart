import 'package:bapenda_getx2/widgets/custom_appbar.dart';
import 'package:bapenda_getx2/widgets/nodata.dart';
import 'package:bapenda_getx2/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notifikasi", leading: true, isLogin: true),
      body: GetBuilder<NotifikasiController>(
        init: NotifikasiController(),
        builder: (controller) {
          if (controller.isFailed) {
            return ShimmerWidget.Items1();
          }

          if (controller.datalist.isEmpty) {
            return NoData(); //menampilkan lotties no data
          }

          if (controller.isLoading) {
            return ShimmerWidget.Items1();
          }
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.datalist.length,
              itemBuilder: (context, index) {
                var datatitem = controller.datalist[index];
                String titlekategori;
                if (datatitem.kategori == 'pelaporan_dikembalikan') {
                  titlekategori = 'Pelaporan Pajak ditolak';
                } else if (datatitem.kategori == 'notif_jatuhtempo') {
                  titlekategori = 'Notifikasi Jatuh Tempo';
                } else {
                  titlekategori = 'Notifikasi';
                }

                return Card(
                  child: ListTile(
                    tileColor:
                        (datatitem.status == "0" || datatitem.status == "1")
                            ? Color.fromARGB(248, 230, 243, 255)
                            : null,
                    leading: CircleAvatar(
                        backgroundColor:
                            datatitem.kategori == "pelaporan_dikembalikan"
                                ? Colors.amber[300]
                                : null,
                        child: datatitem.kategori == "pelaporan_dikembalikan"
                            ? Icon(Icons.autorenew)
                            : Icon(Icons.notification_important)),
                    title: Text('${titlekategori}',
                        style: TextStyle(fontWeight: FontWeight.w600),
                        maxLines:
                            1), // Assuming 'kategori' is the category of notification
                    subtitle: Text(
                        '${datatitem.keterangan}'), // Assuming 'keterangan' is the description of notification
                    trailing: Container(
                      width: Get.width * 0.15,
                      child: Text(
                        '${timeago.format(datatitem.date, locale: 'id')}', // Assuming 'date' is the date of notification
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ),
                    onTap: () {
                      // Add functionality here to handle tap on a notification
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
