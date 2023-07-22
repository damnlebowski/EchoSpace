import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/services/like_post.dart';
import 'package:echospace/services/saved_post.dart';
import 'package:echospace/views/help_screen/help_screen.dart';
import 'package:echospace/views/liked_post_screen/liked_post_screen.dart';
import 'package:echospace/views/saved_post_screen/saved_post_screen.dart';
import 'package:echospace/views/settings_screen/settings_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              Get.to(() => const SettingsPage());
            },
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
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HelpPage(),
              ));
            },
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
    );
  }
}
