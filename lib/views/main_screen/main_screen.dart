// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/services/like_post.dart';
import 'package:echospace/services/saved_post.dart';
import 'package:echospace/services/user_post.dart';
import 'package:echospace/views/liked_post_screen/liked_post_screen.dart';
import 'package:echospace/views/chat_screen/chat_sccreen.dart';
import 'package:echospace/views/create_post_screen/create_post_screen.dart';
import 'package:echospace/views/home_screen/home_screen.dart';
import 'package:echospace/views/main_screen/widgets/bottom_navigation_widget.dart';
import 'package:echospace/views/main_screen/widgets/drawer_widget.dart';
import 'package:echospace/views/profile_screen/profile_screen.dart';
import 'package:echospace/views/search_screen/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({
    super.key,
  });

  final RxInt selectedIndex = 0.obs;
  final RxString widgetTitle = 'Home'.obs;

  final List<Widget> screens = [
    HomeScreen(),
    CreatePostScreen(),
    const ChatScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        backgroundColor: kBgBlack,
        elevation: 2,
        iconTheme: const IconThemeData(color: kWhite),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: kInactiveColor,
          ),
          height: 24,
          width: 70,
          child: Center(
            child: Obx(
              () => Text(
                widgetTitle.value,
                style: const TextStyle(color: kWhite, fontSize: 18),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => SearchScreen());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: DrawerWidget(),
      body: Obx(() => screens[selectedIndex.value]),
      bottomNavigationBar: BottomNavigationWidget(
          selectedIndex: selectedIndex, widgetTitle: widgetTitle),
    );
  }
}

User? getUser() {
  User? user = FirebaseAuth.instance.currentUser;
  return user;
}
