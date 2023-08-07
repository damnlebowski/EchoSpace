import 'package:echospace/controllers/internet_connectivity_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/views/login_screen/login_screen.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
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
    final ConnectivityService connectivityService = Get.find();

    return Obx(
      () {
        if (!connectivityService.hasInternetConnection.value) {
          return connectivityService.showAlert(context);
        }
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
                    onTap: () {
                      verifyOtp(otpController.text.trim());
                    },
                    buttonColor: kRed)
              ],
            ),
          ),
        );
      },
    );
  }

  verifyOtp(String otp) async {
    bool verified = await a.verifyOTP(a.userVerificationId, otp);
    if (verified) {
      bool isExisist = await UserDetails().isUserIdExists(mobile);
      if (isExisist) {
        Get.offAll(() => const MainScreen());
      } else {
        Get.offAll(() => RegisterPage());
      }
    } else {
      return;
    }
  }
}
