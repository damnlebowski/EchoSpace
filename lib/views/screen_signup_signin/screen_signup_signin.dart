import 'dart:developer';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/views/screen_login/screen_login.dart';
import 'package:echospace/views/user_register_screen/user_register_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpOption extends StatelessWidget {
  const SignUpOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBlack,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.040,
              ),
              Image.asset(height: 120, 'assests/EchoSpace.png'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.040,
              ),
              Image.asset('assests/bg_tree.png'),
              ButtonWidget(
                label: 'Sign In',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EmailLoginPage(),
                  ));
                },
                buttonColor: kRed,
              ),
              ButtonWidget(
                label: 'Sign Up',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ));
                },
                buttonColor: kRed,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.040,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 13,
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
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: RichText(
              //       text: TextSpan(
              //           style: DefaultTextStyle.of(context).style.copyWith(
              //                 fontSize: 13,
              //                 color: kWhite,
              //                 decoration: TextDecoration.none,
              //               ),
              //           children: [
              //         const TextSpan(text: 'Already a user? '),
              //         TextSpan(
              //           text: 'Log in',
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               log('Log In');
              //             },
              //           style: const TextStyle(
              //             color: kRed,
              //           ),
              //         )
              //       ])),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
