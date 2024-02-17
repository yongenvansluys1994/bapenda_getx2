import 'package:bapenda_getx2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:bapenda_getx2/core/push_notification/push_notif_single.dart';
import 'package:bapenda_getx2/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ChatController extends GetxController implements DisposableInterface {
  final dashController = Get.find<DashboardController>();
  late AuthModel authModel;
  TextEditingController textController = TextEditingController();
  final RxList<Map<String, dynamic>> isi_chat = RxList<Map<String, dynamic>>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');
  WriteBatch batch = FirebaseFirestore.instance.batch();
  String? id_room;

  @override
  void onInit() {
    super.onInit();
    //fetchChatData();
    authModel = Get.arguments;
    fetchChat();

    //dashController.CountUnseenChat();
    update();
  }

  void fetchChat() {
    FirebaseFirestore.instance
        .collection('rooms')
        .where('participants', arrayContains: authModel.nik)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((roomDoc) async {
      roomDoc.docs.forEach((roomDoc) {
        id_room = "${roomDoc.id}";
        // Dapatkan dokumen ruangan
        final Map<String, dynamic> roomDataRooms =
            roomDoc.data() as Map<String, dynamic>;
        final List<dynamic> participants = roomDataRooms['participants'];

        // Listen to changes in the 'chats' subcollection for the specific room
        FirebaseFirestore.instance
            .collection('rooms')
            .doc(id_room)
            .collection('chats')
            .orderBy('createdAt', descending: true)
            .snapshots()
            .listen((chatQuerySnapshot) async {
          final List<Map<String, dynamic>> updatedRooms = [];

          final participantFutures = participants.map((participant) =>
              FirebaseFirestore.instance
                  .collection('UserTokens')
                  .doc(participant)
                  .get());

          final participantSnapshots = await Future.wait(participantFutures);

          for (final room in chatQuerySnapshot.docs) {
            final Map<String, dynamic> roomDataChats =
                room.data() as Map<String, dynamic>;
            final List<Map<String, dynamic>> participantsInfo = [];

            for (int i = 0; i < participants.length; i++) {
              final DocumentSnapshot userDoc = participantSnapshots[i];

              if (userDoc.exists) {
                final Map<String, dynamic> userData =
                    userDoc.data() as Map<String, dynamic>;
                participantsInfo.add({
                  'participant': participants[i],
                  'avatar': userData['image'],
                  'nama': userData['nama'],
                });
              }
            }

            roomDataChats['participantsInfo'] = participantsInfo;
            updatedRooms.add(roomDataChats);
          }

          isi_chat.assignAll(updatedRooms);
          update();
        });
        updateRead(roomDoc.id);
      });
    });

    update();
  }

  void updateRead(String roomDoc) {
    final docUser =
        FirebaseFirestore.instance.collection('rooms').doc('${id_room}');
    final docChat = docUser.collection('chats');

    docChat
        .where('nikTo', isEqualTo: authModel.nik.toString())
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        batch.update(document.reference, {'read': true});
      });
      batch.commit();
    });
    update();
  }

  Future<void> sendChat() async {
    if (textController.text.isEmpty) {
      RawSnackbar_top(
          message: "Pesan tidak boleh kosong", kategori: "error", duration: 1);
      update();
      return;
    }

    EasyLoading.show();
    FocusManager.instance.primaryFocus?.unfocus();

    final roomId = isi_chat.isEmpty
        ? FirebaseFirestore.instance.collection('rooms').doc().id
        : id_room;
    final roomRef = FirebaseFirestore.instance.collection('rooms').doc(roomId);
    final chatRef = roomRef.collection('chats').doc();

    final jsonroom = {
      'postID': roomId,
      'nikFrom': authModel.nik,
      'nikTo': 'admin',
      'read': false,
      'lastText': textController.text,
      'participants': [authModel.nik, 'admin'],
      'readBy': [authModel.nik],
      'createdAt': FieldValue.serverTimestamp(),
    };

    final jsonchat = {
      'nikFrom': authModel.nik,
      'nikTo': 'admin',
      'text': textController.text,
      'read': false,
      'foto': authModel.foto,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      if (isi_chat.isEmpty) {
        await roomRef.set(jsonroom);
      } else {
        await roomRef.update({
          'lastText': textController.text,
          'readBy': [authModel.nik],
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      await chatRef.set(jsonchat);
      final snap = await FirebaseFirestore.instance
          .collection("UserTokens")
          .doc('admin')
          .get();
      final token = snap['token'];
      sendPushMessage(
          token, "${authModel.nik}", "${textController.text}", "chat");
      FocusManager.instance.primaryFocus?.unfocus();
      hapusisi();
      EasyLoading.dismiss();
    } catch (error) {
      RawSnackbar_top(
          message: "Gagal Mengirim Chat", kategori: "error", duration: 1);
      EasyLoading.dismiss();
    }

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

  void hapusisi() {
    textController.clear();
  }
}
