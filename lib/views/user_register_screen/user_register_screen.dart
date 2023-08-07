import 'package:echospace/controllers/internet_connectivity_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/services/username_availablity.dart';
import 'package:echospace/views/add_avatar_screen/add_avatar_screen.dart';
import 'package:echospace/views/login_screen/login_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:echospace/views/widgets/textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final ConnectivityService connectivityService = Get.find();

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    Get.off(() => MobileLoginPage());
                  },
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
                        onTap: () async {
                          onRegister();

                          Get.to(() => AddAvatarPage(profileDetails: {
                                'name': nameController.text.trim(),
                                'userName': usernameController.text.trim(),
                              }));
                        },
                        buttonColor: kRed)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onRegister() async {
    //checking username availablity
    bool userNameAvailable = await UserNameList()
        .checkForUsernameAvailablity(usernameController.text.trim());
    if (!_formKey.currentState!.validate()) return;

    if (usernameController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty) return;

    if (!userNameAvailable) {
      snack('Error', 'Username already taken.');
      return;
    }
  }
}

snack(String title, String subtitle) {
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }

  Get.snackbar(
    title,
    subtitle,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.grey[800],
    colorText: Colors.red,
    duration: const Duration(seconds: 2),
    animationDuration: const Duration(milliseconds: 100),
    snackStyle: SnackStyle.FLOATING,
  );
}
