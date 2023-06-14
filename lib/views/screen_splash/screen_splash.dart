import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/views/screen_signup_signin/screen_signup_signin.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SignUpOption(),
        ));
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
