import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/views/screen_otp/screen_otp.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class EmailLoginPage extends StatelessWidget {
  EmailLoginPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Sign Up',
                style: TextStyle(color: kWhite),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormFieldWidget(
              lableText: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your email';
                } else if (!value.endsWith('.com')) {
                  return 'Enter a valid email.';
                }
                return null;
              },
            ),
            TextFormFieldWidget(
              lableText: 'Password',
              controller: passwordController,
              isobscure: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'pls enter password';
                }
                return null;
              },
            ),
            const Expanded(child: SizedBox()),
            ButtonWidget(
                label: 'Continue',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CheckOtp(),
                  ));
                },
                buttonColor: kInactiveColor)
          ],
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.lableText,
    required this.controller,
    this.isobscure = false,
    this.keyboardType,
    this.maxLength,
    this.validator,
  });
  final String lableText;
  final TextEditingController controller;
  final bool isobscure;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        obscureText: isobscure,
        controller: controller,
        style: const TextStyle(color: kWhite),
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterStyle: const TextStyle(
            color: kWhite,
          ),
          labelText: lableText,
          labelStyle: const TextStyle(color: kWhite),
          filled: true,
          fillColor: kInactiveColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
