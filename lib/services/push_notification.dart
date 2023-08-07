import 'dart:io';
import 'package:dio/dio.dart';
import 'package:echospace/utils/constants/config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCM {
  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // for sending push notification
  static Future<void> sendPushNotification(
      String userToken, String name, String msg) async {
    try {
      final data = {
        "to": userToken,
        "notification": {
          "title": name,
          "body": msg,
          "android_channel_id": 'chats'
        },
        
      };

      final dio = Dio();
      dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: serverKey,
      };

      final response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
      );

      print('Response status: ${response.statusCode}');

    } catch (e) {
      print('sendPushNotification error: $e');
    }
  }

  //clearing the token
  clearToken() {
    fMessaging.deleteToken();
  }
}
