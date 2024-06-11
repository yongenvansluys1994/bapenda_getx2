import 'dart:io';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  timeago.setLocaleMessages('id', timeago.IdMessages());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Hanya mode potret ke atas diizinkan
  ]);
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Bapenda Etam",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          theme: lightTheme,
          initialBinding: BindingsBuilder(
            () async {
              Get.put(
                Api(),
                permanent: true,
              );
            },
          ),
        );
      },
    ),
  );
}
