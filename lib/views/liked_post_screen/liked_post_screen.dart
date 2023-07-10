// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/controllers/internet_connectivity_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikedPage extends StatelessWidget {
   LikedPage({super.key, required this.likedList});
  final List<String> likedList;
  final ConnectivityService connectivityService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!connectivityService.hasInternetConnection.value) {
         return connectivityService.showAlert(context);
        }
      return Scaffold(
        backgroundColor: kBgBlack,
        appBar: AppBar(
          backgroundColor: kBgBlack,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            ),
          ),
          title: Text(
            "Post you've liked",
            style: TextStyle(color: kWhite),
          ),
        ),
        body: likedList.isNotEmpty
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user_posts')
                    .where('postId', whereIn: likedList)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No saved post',
                        style: TextStyle(color: kWhite, fontSize: 20),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        bool isLiked = (snapshot.data!.docs[index].data()['likes']
                                as List<dynamic>)
                            .contains(
                               getUser()!.phoneNumber!);
                        bool isSaved = (snapshot.data!.docs[index].data()['saved']
                                as List<dynamic>)
                            .contains(
                               getUser()!.phoneNumber!);
                        return PostCardWidget(
                          isLiked: isLiked,
                          documentSnapshot: snapshot.data!.docs[index],
                          isSaved: isSaved,
                        );
                      });
                })
            : Center(
                child: Text(
                  'No liked post',
                  style: TextStyle(color: kWhite, fontSize: 20),
                ),
              ),
      );
    },
    );
  }
}
