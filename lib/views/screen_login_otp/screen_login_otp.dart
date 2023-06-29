import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:echospace/services/user_connections.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/views/screen_home/screen_home.dart';
import 'package:echospace/views/screen_login/screen_login.dart';
import 'package:echospace/views/screen_main/screen_main.dart';
import 'package:echospace/views/user_register_screen/user_register_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:echospace/views/widgets/textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckLoginOtp extends StatelessWidget {
  const CheckLoginOtp({super.key, required this.mobile});

  final String mobile;

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBgBlack,
        title: Image.asset(
          'assests/EchoSpace.png',
          width: 200,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            kHeight10,
            const CustomText(
              label: 'Verify your phone number',
              fontSize: 24,
            ),
            kHeight10,
            const CustomText(
              label: 'Enter the 6 digit code sent to',
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              label: mobile,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormFieldWidget(
                  lableText: 'Verification Code',
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6),
            ),
            const Expanded(child: SizedBox()),
            ButtonWidget(
                label: 'Continue',
                onTap: () async {
                  verifyOtp(otpController.text.trim());
                },
                buttonColor: kRed)
          ],
        ),
      ),
    );
  }

  verifyOtp(String otp) async {
    bool verified = await authObj.verifyOtp(otp);
    if (verified) {
      bool isExisist = await UserDetails().isUserIdExists(mobile);
      if (isExisist) {
        Get.offAll(MainScreen());
        // await UserConnections().getAllConnectionPost();
      } else {
        Get.offAll(RegisterPage());
      }
    } else {
      return;
    }
  }
}
