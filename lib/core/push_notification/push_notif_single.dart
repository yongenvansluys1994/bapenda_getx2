import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:http/http.dart' as http;

void sendPushMessage(
    String token, String title, String body, String desc) async {
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${ApiFCM}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'desc': desc
          },
          "to": token,
        },
      ),
    );
  } catch (e) {
    print("error push notification");
  }
}
