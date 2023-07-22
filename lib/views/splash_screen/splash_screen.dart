import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/views/login_screen/login_screen.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/user_register_screen/user_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:echospace/utils/functions/get_user.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  gotoNextPage() async {
    User? userLogin = getUser();
    bool isExisist = false;
    if (userLogin != null) {
      isExisist = await UserDetails().isUserIdExists(userLogin.phoneNumber!);
    }

    await Future.delayed(const Duration(milliseconds: 200), () async {
      if (userLogin == null) {
        Get.off(() => MobileLoginPage());
      }
      if (userLogin != null && !isExisist) {
        Get.off(() => RegisterPage());
      } else if (userLogin != null && isExisist) {
        Get.off(() => MainScreen());
      }
    });
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      gotoNextPage();
    });

    return Scaffold(
      backgroundColor: kBgBlack,
      body: Center(
        child: Image.asset('assests/EchoSpace.png'),
      ),
    );
  }
}
