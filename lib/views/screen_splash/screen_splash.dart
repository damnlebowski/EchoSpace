import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/views/screen_login/screen_login.dart';
import 'package:echospace/views/screen_main/screen_main.dart';
import 'package:echospace/views/user_register_screen/user_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  Splash({super.key});
  // HomeController obj = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      User? userLogin = FirebaseAuth.instance.currentUser;
      bool isExisist = false;
      if (userLogin != null) {
        isExisist = await UserDetails().isUserIdExists(userLogin.phoneNumber!);
      }

      await Future.delayed(const Duration(milliseconds: 10), () async {
        if (userLogin == null) {
          Get.off(MobileLoginPage());
        }
        if (userLogin != null && !isExisist) {
          Get.off(RegisterPage());
        } else if (userLogin != null && isExisist) {
          Get.off(MainScreen());
        }
      });
    });
    return Scaffold(
      backgroundColor: kBgBlack,
      body: Center(
        child: Image.asset('assests/EchoSpace.png'),
      ),
    );
  }
}
