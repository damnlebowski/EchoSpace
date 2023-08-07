import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/utils/functions/get_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserStatus {
  static updateActiveStatus(bool status) async {
    print('----------->>> ${AppLifecycleState.values}');
    log('Status ------------> $status');

    final ref = FirebaseFirestore.instance;
    if (status == true) {
      String? token;
      FirebaseMessaging fMessaging = FirebaseMessaging.instance;

      await fMessaging.requestPermission();

      await fMessaging.getToken().then((t) {
        if (t != null) {
          token = t;
        }
      });
      log('Push Token: $token');

      await ref
          .collection('user_details')
          .doc(getUser()!.phoneNumber)
          .update({'is_online': status, 'fcmToken': token});
    } else {
      await ref.collection('user_details').doc(getUser()!.phoneNumber).update({
        'is_online': status,
        'lastSeen': Timestamp.now(),
      });
    }
  }
}
