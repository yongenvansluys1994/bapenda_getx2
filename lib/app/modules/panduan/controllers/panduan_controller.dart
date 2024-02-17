import 'package:bapenda_getx2/app/modules/dashboard/models/auth_model_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PanduanController extends GetxController {
  late AuthModel authModel;
  bool isLoading = false;
  bool isEmpty = false;
  bool isFailed = false;
  final RxList<DocumentSnapshot> documents = RxList<DocumentSnapshot>();

  @override
  void onInit() {
    super.onInit();
    authModel = Get.arguments;
    fetchPanduan();
    update();
  }

  void fetchPanduan() {
    FirebaseFirestore.instance
        .collection('panduan_video')
        .snapshots()
        .listen((chatQuerySnapshot) {
      documents.assignAll(chatQuerySnapshot.docs);
    });
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
