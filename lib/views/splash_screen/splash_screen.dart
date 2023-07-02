import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/views/login_screen/login_screen.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/user_register_screen/user_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  Splash({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      User? userLogin = getUser();
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
