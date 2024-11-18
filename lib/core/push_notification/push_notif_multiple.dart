import 'dart:convert';

import 'package:bapenda_getx2/app/modules/dashboard/services/dashboard_services.dart';
import 'package:bapenda_getx2/utils/app_const.dart';
import 'package:bapenda_getx2/widgets/logger.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

void sendPushMessagesChatMultiple(List<Map<String, String>> allTokens3,
    String title, String body, String desc,
    [Map<String, dynamic>? jsonDecode]) async {
  // Print to check the JSON format of jsonDecode
  print(jsonEncode(jsonDecode));

  final getAccess = GetAccess();
  // Ensure token is valid or refresh if expired
  await getAccess.checkAndRefreshToken();
  // Retrieve token from GetStorage (ensured fresh by checkAndRefreshToken)
  final box = GetStorage();
  final tokenAccess = box.read("token_access") ?? "";

  try {
    for (Map<String, String> tokenInfo in allTokens3) {
      final response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenAccess',
        },
        body: jsonEncode(
          <String, dynamic>{
            'message': {
              'token': tokenInfo['token'],
              'notification': {
                'title': title,
                'body': body,
              },
              'data': {
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'id': '1',
                'status': 'done',
                'desc': desc,
                'json_value':
                    jsonEncode(jsonDecode) // Encode jsonDecode as JSON string
              },
              'android': {
                'notification': {'click_action': 'TOP_STORY_ACTIVITY'}
              },
              'apns': {
                'payload': {
                  'aps': {'category': 'NEW_MESSAGE_CATEGORY'}
                }
              }
            }
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Push notification sent successfully");
      } else {
        print(
            "Failed to send push notification. Status code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    }
  } catch (e) {
    print("Error sending push notification: $e");
  }
}
