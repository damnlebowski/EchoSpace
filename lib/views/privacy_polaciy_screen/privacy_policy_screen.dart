import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            )),
        backgroundColor: kBgBlack,
        title: const Text('Privacy Policy', style: TextStyle(color: kWhite)),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy - EchoSpace',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Information We Collect:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1.1. Personal Information:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              Text(
                'When you create an account on EchoSpace, we may collect personal information such as your name, Phone Number, profile picture, and any other information you choose to provide.',
                style: TextStyle(
                  fontSize: 16,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1.2. User-generated Content:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              Text(
                'We collect the content you create and share on EchoSpace, including posts, comments, photos.',
                style: TextStyle(
                  fontSize: 16,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '2. How We Use Your Information:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '2.1. Providing and Improving Services:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              Text(
                'We use the information we collect to provide, maintain, and improve EchoSpace. This includes personalizing your experience, developing new features, and analyzing user behavior to enhance our platform.',
                style: TextStyle(
                  fontSize: 16,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '2.2. Communication:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              Text(
                'We may use your mo to phone number you notifications, updates, and important information regarding EchoSpace. You can opt out of these communications at any time.',
                style: TextStyle(
                  fontSize: 16,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 8),
              // ... continue styling the remaining sections and paragraphs
              Text(
                '6. Changes to the Privacy Policy:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We may update this Privacy Policy from time to time. Any changes will be posted on this page. By continuing to use EchoSpace after the revised Privacy Policy becomes effective, you acknowledge and agree to the updated terms.',
                style: TextStyle(
                  fontSize: 16,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '7. Contact Us:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'If you have any questions, concerns, or suggestions regarding our Privacy Policy or the practices of EchoSpace, please contact us at damn.lebowski@protonmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Please review this Privacy Policy carefully, and if you do not agree with any part of it, please refrain from using EchoSpace. Your continued use of our platform signifies your acceptance of this Privacy Policy.',
                style: TextStyle(
                  fontSize: 16,
                  color: kWhite,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
