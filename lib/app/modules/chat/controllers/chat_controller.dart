import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:bapenda_getx2/app/modules/chat/models/model_chat.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/app/modules/ekitiran/models/rt_model.dart';
import 'package:bapenda_getx2/core/push_notification/push_notif_multiple.dart';
import 'package:bapenda_getx2/widgets/dismiss_keyboard.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  late RTModel rtModel;
  final storage = GetStorage();

  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  late AuthModel authModel;
  RxList<ModelChat> datalist = <ModelChat>[].obs;
  TextEditingController textController = TextEditingController();
  String? roomID;
  String? sender_name;
  bool isHaveRoom = false;
  bool isFirstOpen = false;
  String? typeRoom;
  List<Map<String, String>> token_sender = [];

  @override
  void onInit() async {
    super.onInit();
    authModel = Get.arguments;
    final resultCheckRoom = await checkRoom(int.parse("${authModel.idUserwp}"));
    if (resultCheckRoom!.isNotEmpty) {
      isHaveRoom = true;
      roomID = resultCheckRoom[0].roomId;
      List<String> allToken = resultCheckRoom[0].allToken;

      for (String token in allToken) {
        token_sender.add({"token": token});
      }
      logInfo(jsonEncode(token_sender));
      sender_name = "Chat Admin";
      update();
      FetchData(roomID);
      readChat(int.parse("${authModel.idUserwp}"), roomID);
    } else {
      isHaveRoom = false;
      isFirstOpen = true;
      logInfo("tidak ada room chat");
    }
    listenFCM();
    update();
  }

  void changeisFirstOpen({required String typeRoom_value}) {
    isFirstOpen = false;
    typeRoom = typeRoom_value;
    sender_name = "Chat Admin";
    update();
  }

  Future send_Chat() async {
    String typeChat = isHaveRoom ? 'lama' : 'baru';
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
      update();
    } else {
      var userRtData = storage.read('user_rt');

      RTModel rtModel = userRtData != null
          ? RTModel.fromJson(userRtData)
          : RTModel(
              id_user_rt: "",
              nama: "",
              kecamatan: "",
              kelurahan: "",
              rt: "",
              isSynced: false,
            );
      try {
        // Memanggil sendChat dan menunggu hasilnya
        logInfo('${typeRoom}');
        var response = await sendChat({
          'id_userwp': int.parse("${authModel.idUserwp}"),
          'room_id': '${roomID}',
          'text': '${textController.text}',
          'nama_rt': rtModel.rt != ""
              ? '${rtModel.nama} - RT. ${rtModel.rt} ${rtModel.kelurahan}'
              : '',
          'type': typeChat,
          'type_room': '${typeRoom}',
          'target_id_userwp': '',
          'chat_room': 'wp',
        });
        //print(response);

        // Memeriksa status respons
        if (response.statusCode == 200) {
          dismissKeyboard();
          // Mengolah respons jika sukses
          var responseData = response.data;
          var decodedResponse = jsonDecode(responseData);
          var data = decodedResponse['data'];
          // Iterasi melalui setiap item di 'data' dan tambahkan ke datalist
          for (var item in data) {
            datalist.add(ModelChat.fromJson(item));
          }
          // Mengurutkan datalist berdasarkan sent_at (terbaru di paling bawah)
          datalist.sort((a, b) => b.sentAt.compareTo(a.sentAt));
          // Update UI
          if (isHaveRoom == false) {
            isHaveRoom = true;
          }
          update();
          if (token_sender.isEmpty) {
            await checkRoomFirst();
          }
          sendPushMessagesChatMultiple(token_sender, "${authModel.nama}",
              "${textController.text}", "chat_masuk", jsonDecode(responseData));
          textController.clear();
          // Lakukan sesuatu dengan responseData
        } else {
          // Mengolah respons jika gagal
          logInfo("Failed to send message: ${response.statusMessage}");
        }
      } catch (e) {
        // Menangani error
        print("Error: $e");
      }

      update();
    }
  }

  Future send_NewChat() async {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
      update();
    } else {
      var userRtData = storage.read('user_rt');

      RTModel rtModel = userRtData != null
          ? RTModel.fromJson(userRtData)
          : RTModel(
              id_user_rt: "",
              nama: "",
              kecamatan: "",
              kelurahan: "",
              rt: "",
              isSynced: false,
            );
      sendChat({
        'id_userwp': '${authModel.idUserwp}',
        'id_sender': '${"id_sender"}',
        'nama_rt': rtModel.rt != ""
            ? '${rtModel.nama} - RT. ${rtModel.rt} ${rtModel.kelurahan}'
            : '',
        'text': '${textController.text}',
        'type': 'baru',
      });

      update();
    }
  }

  Future<void> FetchData(roomID) async {
    datalist.clear();
    try {
      isLoading = true;

      final datauser = await getChat(roomID);

      if (datauser == null) {
        isFailed = true;
      } else if (datauser.isEmpty) {
        isEmpty = true;
      } else {
        datalist.addAll(datauser);
        isEmpty = false;
      }

      isLoading = false;
      update();
    } on DioError catch (ex) {
      var errorMessage = "";
      if (ex.type == DioErrorType.connectionTimeout ||
          ex.type == DioErrorType.connectionError ||
          ex.type == DioErrorType.receiveTimeout ||
          ex.type == DioErrorType.sendTimeout) {
        errorMessage = "Limit Connection, Koneksi anda bermasalah";
      } else {
        errorMessage = "$ex";
      }
      RawSnackbar_top(message: "$errorMessage", kategori: "error", duration: 4);
      update();
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        if (message.data['desc'] == "chat_masuk") {
          var decodedResponse = jsonDecode(message.data['json_value']);

          // Check if 'data' exists in decodedResponse and is not null
          if (decodedResponse.containsKey('data') &&
              decodedResponse['data'] != null) {
            var data = decodedResponse['data'];
            if (data is List) {
              for (var item in data) {
                datalist.add(ModelChat.fromJson(item));
              }
              datalist.sort((a, b) => b.sentAt.compareTo(a.sentAt));

              // Update UI
              update();
              //chatRoomCon.FetchData();
            } else {
              print(
                  "Expected 'data' to be a list, but got: ${data.runtimeType}");
            }
          } else {
            print("No 'data' field in json_value or 'data' is null.");
          }
        }
        //Get.toNamed(Routes.LAPOR_PAJAK, arguments: authModel);
      }
    });
  }

  Future checkRoomFirst() async {
    final resultCheckRoom = await checkRoom(int.parse("${authModel.idUserwp}"));
    roomID = resultCheckRoom![0].roomId;
    List<String> allToken = resultCheckRoom[0].allToken;

    for (String token in allToken) {
      token_sender.add({"token": token});
    }
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
