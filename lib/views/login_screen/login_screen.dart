import 'dart:developer';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/services/otp_auth_services.dart';
import 'package:echospace/views/otp_screen/otp_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:echospace/views/widgets/textform_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

OtpAuth authObj = OtpAuth();

class MobileLoginPage extends StatelessWidget {
  MobileLoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBlack,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(height: 160, 'assests/EchoSpace.png'),
                  const Positioned(
                    left: 70,
                    top: 40,
                    child: CustomText(
                      label: 'Sign In to',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Image.asset('assests/bg_tree.png'),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormFieldWidget(
                    lableText: 'Mobile',
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your mobile';
                      } else if (value.length != 10) {
                        return 'Enter a valid mobile.';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              ButtonWidget(
                  label: 'Send OTP',
                  onTap: () async {
                    //check validate
                    if (!_formKey.currentState!.validate()) return;

                    //send otp
                    sendOtp();

                    //navigate to otp section
                    Get.to(() => CheckLoginOtp(
                        mobile: '+91${mobileController.text.trim()}'));
                  },
                  buttonColor: kRed),
              kHeight25,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 12,
                        color: kWhite,
                        decoration: TextDecoration.none),
                    children: [
                      const TextSpan(
                        text: "By continuing, you agree to our ",
                        style: TextStyle(),
                      ),
                      TextSpan(
                        text: "User Agreement",
                        style: const TextStyle(
                          color: kRed,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log('User Agreement');
                          },
                      ),
                      const TextSpan(
                        text: " and ",
                        style: TextStyle(),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(
                          color: kRed,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log('Privacy Policy');
                          },
                      ),
                      const TextSpan(
                        text: ".",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sendOtp() async {
    await authObj.sendOtp('+91${mobileController.text.trim()}');
  }
}
