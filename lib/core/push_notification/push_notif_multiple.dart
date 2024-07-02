import 'dart:convert';

import 'package:bapenda_getx2/app/core/api/api.dart';
import 'package:http/http.dart' as http;

void sendPushMessagesChat(List<Map<String, String>> allTokens3, String title,
    String body, String desc,
    [jsonDecode]) async {
  try {
    for (Map<String, String> tokenInfo in allTokens3) {
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
              'desc': desc,
              'json_value': jsonDecode,
            },
            "to": tokenInfo['token'],
          },
        ),
      );
    }
  } catch (e) {
    print("error sending push notifications: $e");
  }
}
