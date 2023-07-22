// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:echospace/controllers/internet_connectivity_controller.dart';
import 'package:echospace/controllers/main_page_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/views/chat_screen/chat_sccreen.dart';
import 'package:echospace/views/create_post_screen/create_post_screen.dart';
import 'package:echospace/views/home_screen/home_screen.dart';
import 'package:echospace/views/main_screen/widgets/bottom_navigation_widget.dart';
import 'package:echospace/views/main_screen/widgets/drawer_widget.dart';
import 'package:echospace/views/profile_screen/profile_screen.dart';
import 'package:echospace/views/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({
    super.key,
  });

  MainPageController obj = MainPageController();

  final List<Widget> screens = [
    HomeScreen(),
    CreatePostScreen(),
    ChatScreen(),
    ProfilePage(),
  ];

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
                    obj.widgetTitle.value,
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
          body: Obx(() => screens[obj.selectedIndex.value]),
          bottomNavigationBar: BottomNavigationWidget(
              selectedIndex: obj.selectedIndex, widgetTitle: obj.widgetTitle),
        );
      },
    );
  }
}

