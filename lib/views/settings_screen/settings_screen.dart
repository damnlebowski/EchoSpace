import 'package:echospace/services/otp_auth_services.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/utils/constants/widgets.dart';
import 'package:echospace/views/privacy_polaciy_screen/privacy_policy_screen.dart';
import 'package:echospace/views/splash_screen/splash_screen.dart';
import 'package:echospace/views/user_agreement_screen/user_agreement_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: kWhite),
        ),
        backgroundColor: kBgBlack,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            )),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.menu_book_outlined,
              color: kWhite,
            ),
            title: const CustomText(
              label: "User Agreement",
              fontSize: 16,
            ),
            onTap: () {
              Get.to(() => UserAgreementPage());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: kWhite,
            ),
            title: const CustomText(
              label: "Privacy Policy",
              fontSize: 16,
            ),
            onTap: () {
              Get.to(() => PrivacyPolicyPage());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.warning_amber_outlined,
              color: kWhite,
            ),
            title: const CustomText(
              label: "Report an Issue",
              fontSize: 16,
            ),
            onTap: () async {
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'damn.lebowski@protonmail.com',
                query: encodeQueryParameters(<String, String>{
                  'subject': 'EchoSpace related query',
                }),
              );
              await launchUrl(emailLaunchUri);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: kWhite,
            ),
            title: const CustomText(
              label: "Log out",
              fontSize: 16,
            ),
            onTap: () {
              OtpAuth().logout();
              Get.offAll(Splash());
            },
          ),
          const Expanded(
            child: kHeight10,
          ),
          FutureBuilder<PackageInfo>(
            future: _getPackageInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.hasData) {
                return Center(
                    child: Text(
                  'Version ${snapshot.data!.version}',
                  style: const TextStyle(color: kWhite),
                ));
              } else {
                return const Text('');
              }
            },
          ),
          kHeight10,
        ],
      ),
    );
  }

  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
