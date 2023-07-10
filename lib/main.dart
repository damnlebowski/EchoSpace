import 'package:echospace/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controllers/internet_connectivity_controller.dart';
import 'utils/constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
      home: Splash(),
    );
  }
}
