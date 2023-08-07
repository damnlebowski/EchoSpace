import 'dart:developer';

import 'package:echospace/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/internet_connectivity_controller.dart';
import 'utils/constants/colors.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  registerNoti();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(ConnectivityService());
      }),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: swatchWhite),
      home: const Splash(),
    );
  }
}

registerNoti() async {
  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  log('\nNotification Channel Result: $result');
}
