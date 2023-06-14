import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:echospace/views/screen_login/screen_login.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class CheckOtp extends StatelessWidget {
  const CheckOtp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
            const CustomText(
              label: 'email',
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            kHeight10,
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormFieldWidget(
                  lableText: 'Verification Code',
                  controller: otpController,
                  // keyboardType: TextInputType.number,
                  maxLength: 6),
            ),
            const CustomText(label: 'Resend in 0:59', fontSize: 16),
            const Expanded(child: SizedBox()),
            ButtonWidget(
                label: 'Continue', onTap: () {}, buttonColor: kInactiveColor)
          ],
        ),
      ),
    );
  }
}
