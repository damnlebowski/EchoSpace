// ignore_for_file: prefer_const_constructors

import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAgreementPage extends StatelessWidget {
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
        title: Text(
          'User Agreement',
          style: TextStyle(color: kWhite),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Agreement',
              style: TextStyle(
                color: kWhite,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to EchoSpace!',
              style: TextStyle(
                color: kWhite,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'This User Agreement ("Agreement") governs your access to and use of the EchoSpace platform ("Platform"), including any content, features, and services provided within the Platform. Please read this Agreement carefully before using EchoSpace. By accessing or using the Platform, you agree to be bound by the terms and conditions outlined in this Agreement.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(
                color: kWhite,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'By accessing or using EchoSpace, you acknowledge that you have read, understood, and agree to comply with this Agreement. If you do not agree to these terms, please refrain from accessing or using the Platform.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. User Eligibility',
              style: TextStyle(
                color: kWhite,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'You must be at least 13 years of age to use EchoSpace. If you are under the age of 18, you must have the consent and supervision of a parent or legal guardian. By using the Platform, you represent and warrant that you meet the eligibility requirements mentioned above.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. User Account',
              style: TextStyle(
                color: kWhite,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'To access certain features of EchoSpace, you may need to create a user account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to provide accurate, current, and complete information during the registration process. In case of any unauthorized use of your account, you must immediately notify us.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. User Conduct',
              style: TextStyle(
                color: kWhite,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'While using EchoSpace, you agree to abide by the following guidelines:',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Respect other users and refrain from engaging in any harmful, threatening, or abusive behavior.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Do not use the Platform for any illegal or unauthorized purposes.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Refrain from posting or sharing content that violates intellectual property rights, privacy rights, or any applicable laws.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Do not impersonate or misrepresent yourself or others.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Refrain from engaging in spamming, phishing, or any other form of malicious activity.',
              style: TextStyle(
                color: kWhite,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
