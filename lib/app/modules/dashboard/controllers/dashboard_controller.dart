import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';

import 'package:bapenda_getx2/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_getpelaporanuser.dart';
import 'package:bapenda_getx2/app/modules/lapor_pajak/models/model_objekku.dart';
import 'package:bapenda_getx2/app/modules/myprofil/models/model_ads.dart';
import 'package:bapenda_getx2/app/modules/notifikasi/models/model_notifikasi.dart';
import 'package:bapenda_getx2/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/getdialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:bapenda_getx2/app/modules/dashboard/services/dashboard_services.dart';
import 'package:bapenda_getx2/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController with AuthCacheService {
  http.Client httpClient = http.Client();
  late AuthModel authModel;
  bool isLoadingAds = false;
  bool isEmptyAds = false;
  bool isFailedAds = false;
  bool isLoadingPPID = false;
  bool isEmptyPPID = false;
  bool isFailedPPID = false;
  RxList<ModelAds> datalistAds = <ModelAds>[].obs;
  RxList<ModelAds> datalistPPID = <ModelAds>[].obs;
  RxList<ModelListNotifikasi> datalistNotifikasi = <ModelListNotifikasi>[].obs;
  String unread_chat_count = "0";
  late String tokenMsg;
  int tot_pelaporan = 0;

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  RxList<ModelObjekku> datalist2 = <ModelObjekku>[].obs;
  RxList list_id_wajib_pajak = [].obs;

  RxList<ModelGetpelaporanUser> datalist = <ModelGetpelaporanUser>[].obs;

  DashboardServices services;
  //Api api;
  DashboardController(this.services);

  @override
  void onInit() async {
    // TODO: implement onInit

    final box = GetStorage();
    var user = box.read(STORAGE_LOGIN_USER_DATA);

    authModel = AuthModel.fromJson(user);
    super.onInit();
    requestPermission();
    loadFCM();
    listenFCM();

    checkNotifikasi();
    checkLatestVersion();
    fetchPajak();
    fetchAds();
    fetchPPID();
    row_pelaporan();
    hasUnreadChat();
    update();
  }


  void logout() {
    removeToken();
    removeUserdata();

    print("Tesss");
    Get.offNamed(Routes.LOGIN);

    //Get.delete<DashboardController>(force: true);
  }

  Insert() {
    EasyLoading.show(status: 'loading...');
    update();
    services.getdata({
      "nik": "5555",
      "password": "123",
    }).then(
      (value) async {
        var data =
            json.decode(value); //mengubah json jadi array agar bisa dipanggil
        if (data['success'] == true) {
          Get.snackbar("sukses", "Data Benar");
        } else {
          Get.snackbar("sukses", "Data Salah");
        }
      },
    ).catchError(
      (e) {
        Get.snackbar("gagal", "gagal");
      },
    ).then(
      (value) {
        EasyLoading.dismiss();
        update();
      },
    );
  }

  void tombolpesan() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(authModel.nik)
        .get();
    String token = snap['token'];
    //print(token);
    sendPushMessage(token, "Tes Berita", "Isi Berita", CHAT);
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ignore: unused_local_variable
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        if (message.data['desc'] == "bayar_lunas") {
          getDefaultDialog().onFixWithHandler(
            title: "Pembayaran telah diterima",
            desc: "Terima kasih atas kepercayaan anda menggunakan Bapenda Etam",
            kategori: "success",
            handler: () {
              if (Get.currentRoute == Routes.EBILLING) {
                Get.back(); //mundur 1x
              } else if (Get.currentRoute == Routes.VA_PAGE) {
                Get.back();
                Get.back();
                Get.back(); //mundur 3x
              } else if (Get.currentRoute == Routes.QRIS_PAGE) {
                Get.back();
                Get.back();
                Get.back(); //mundur 3x
              }
              //Get.currentRoute == Routes.EBILLING ? Get.back() : null;
              Get.back(); //tutup dialog sukses
            },
          );
        }else if (message.data['desc'] == "chat_masuk") {
          hasUnreadChat();
          update();
        }

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              sound: RawResourceAndroidNotificationSound('notif'),
              playSound: true,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'ic_notification',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notif'),
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void checkLatestVersion() async {
    var response = await http.get(Uri.parse("${baseUrl}/cek_utilitas/"));
    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    String? DBVersion = data[0]["version"];
    if (int.parse(DBVersion!) > currentversion) {
      print("tampilkan dialog");
      GetDialogDismissible(
          currentversion: currentversion, DBVersion: DBVersion);
    } else {
      if (Get.arguments == "login" || Get.arguments == "autologin") {
        showBanner();
      }
    }
  }

  void checkNotifikasi() async {
    final datauser = await getNotifikasi(authModel.nik);

    if (datauser == null) {
      print("tidak ada notifikasi");
    } else if (datauser.isEmpty) {
      print("tidak ada notifikasi");
    } else {
      datalistNotifikasi.addAll(datauser);
      // Check if any notification has a status of '0'
      bool hasStatusZero =
          datalistNotifikasi.any((notifikasi) => notifikasi.status == '0');

      if (hasStatusZero) {
        getDefaultDialog().onFixNotifikasi(
            title: "Notifikasi Untuk Anda",
            kategori: "warning",
            datalist: datalistNotifikasi);
      }
    }
  }

  fetchPajak() {
    //EasyLoading.show(status: 'loading...');
    update();
    services
        .getPajak(authModel.nik)
        .then(
          (value) async {
            datalist2.addAll(value!);

            list_id_wajib_pajak
                .addAll(datalist2.map((obj) => obj.idWajibPajak));
            update();
            //print(jsonEncode(list_id_wajib_pajak.toList()));
          },
        )
        .catchError(
          (e) {},
        )
        .then(
          (value) {
            fetchSPT();
            update();
          },
        );
  }

  fetchSPT() {
    List list_wajibpajak = list_id_wajib_pajak.toList();
    //EasyLoading.show(status: 'loading...');
    services.getSPT(list_wajibpajak).then(
      (value) async {
        datalist.addAll(value!);
        update();
      },
    ).catchError(
      (e) {},
    );
  }

  fetchAds() {
    isLoadingAds = true;
    //EasyLoading.show(status: 'loading...');
    update();
    services.getAds().then(
      (value) async {
        datalistAds.addAll(value!);
        isLoadingAds = false;
        update();
      },
    ).catchError(
      (e) {
        isFailedAds = true;
      },
    );
  }

  fetchPPID() {
    isLoadingPPID = true;
    //EasyLoading.show(status: 'loading...');
    update();
    services.getPPID().then(
      (value) async {
        datalistPPID.addAll(value!);
        isLoadingPPID = false;
        update();
      },
    ).catchError(
      (e) {
        isFailedPPID = true;
      },
    );
  }

  void row_pelaporan() async {
    var response =
        await http.get(Uri.parse("${URL_APP}/badge/${authModel.nik}"));
    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];

    tot_pelaporan = int.parse(data[0]["tot_data"]);
  }

  void showBanner() async {
    getDefaultDialog().BannerDashboard(
        title: "Selamat Datang",
        desc: "Nikmati fitur-fitur terbaru pada Big Update Bapenda Etam");
    update();
  }

  void hasUnreadChat() async {
    unread_chat_count = "0";
    var response = await httpClient
        .get(Uri.parse("${URL_APPSIMPATDA}/chat/has_unread.php?id_userwp=${authModel.idUserwp}"));
    List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
    unread_chat_count = data[0]["unread_chat_count"];
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
