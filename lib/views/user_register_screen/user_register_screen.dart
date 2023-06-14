import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/views/add_avatar_screen/add_avatar_screen.dart';
import 'package:echospace/views/screen_login/screen_login.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
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
                'Log In',
                style: TextStyle(color: kWhite),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  lableText: 'Name',
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your Name.';
                    }
                    return null;
                  },
                ),
                TextFormFieldWidget(
                  lableText: 'User Name',
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your Username.';
                    } else if (value.length < 8) {
                      return 'Username should be atleast 8 character.';
                    }
                    return null;
                  },
                ),
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
                // TextFormFieldWidget(
                //   lableText: 'Mobile',
                //   controller: mobileController,
                //   keyboardType: TextInputType.phone,
                //   maxLength: 10,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'please enter your mobile';
                //     } else if (value.length != 10) {
                //       return 'Enter a valid mobile.';
                //     }
                //     return null;
                //   },
                // ),
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
                const CustomText(
                  label:
                      "* User Name Should be unique and doesn't contain whitespace or special characters.",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .13,
                ),
                ButtonWidget(
                    label: 'Continue',
                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddAvatarPage(),
                      ));
                    },
                    buttonColor: kInactiveColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
