// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/services/like_post.dart';
import 'package:echospace/services/saved_post.dart';
import 'package:echospace/services/user_post.dart';
import 'package:echospace/views/liked_post_screen/liked_post_screen.dart';
import 'package:echospace/views/saved_post_screen/saved_post_screen.dart';
import 'package:echospace/views/screen_chat/screen_chat.dart';
import 'package:echospace/views/screen_create_post/screen_create_post.dart';
import 'package:echospace/views/screen_home/screen_home.dart';
import 'package:echospace/views/screen_profile/screen_profile.dart';
import 'package:echospace/views/screen_search/screen_search.dart';
import 'package:echospace/views/screen_user_profile/screen_user_profile.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

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
      drawer: Drawer(
        backgroundColor: kBgBlack,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: kInactiveColor)),
                ),
                child: Image.asset('assests/EchoSpace.png')),
            ListTile(
              leading: const Icon(
                Icons.arrow_circle_up_outlined,
                color: kWhite,
              ),
              title: const CustomText(
                label: "Post you've liked",
                fontSize: 16,
              ),
              onTap: () async {
                List<String> likedList = await LikedPosts().userLikedPost();
                Get.to(() => LikedPage(
                      likedList: likedList,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.save_outlined,
                color: kWhite,
              ),
              title: const CustomText(
                label: "Post you've saved",
                fontSize: 16,
              ),
              onTap: () async {
                List<String> savedList = await SavedPosts().userSavedPost();
                Get.to(() => SavedPage(
                      savedList: savedList,
                    ));
              },
            ),
            const Divider(
              color: kInactiveColor,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: kWhite,
              ),
              title: const CustomText(
                label: "Settings",
                fontSize: 16,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.help,
                color: kWhite,
              ),
              title: const CustomText(
                label: 'Help',
                fontSize: 16,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.share_outlined,
                color: kWhite,
              ),
              title: const CustomText(
                label: "Share",
                fontSize: 16,
              ),
              onTap: () async {
                await Share.share(
                  'Hello, check out this awesome EchoSpace!\nhttps://play.google.com/store/apps/details?id=com.lebowski.echospace',
                );
              },
            ),
          ],
        ),
      ),
      body: Obx(() => screens[selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 2,
          type: BottomNavigationBarType.fixed,
          backgroundColor: kBgBlack,
          selectedItemColor: kRed,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wechat_outlined),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex.value,
          onTap: (index) {
            selectedIndex.value = index;
            if (index == 0) {
              widgetTitle.value = 'Home';
            } else if (index == 1) {
              widgetTitle.value = 'Create';
            } else if (index == 2) {
              widgetTitle.value = 'Chat';
            } else if (index == 3) {
              widgetTitle.value = 'Profile';
            }
          },
        ),
      ),
    );
  }
}
