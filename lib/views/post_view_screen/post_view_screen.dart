import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/controllers/internet_connectivity_controller.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/services/upload_post_firebase.dart';
import 'package:echospace/services/user_post.dart';
import 'package:echospace/utils/functions/alert.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPostPage extends StatelessWidget {
   ViewPostPage({super.key, required this.documentSnapshot});

  final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot;
  final ConnectivityService connectivityService = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isLiked = (documentSnapshot['likes'] as List<dynamic>)
        .contains(getUser()!.phoneNumber!);
    bool isSaved = (documentSnapshot['saved'] as List<dynamic>)
        .contains(getUser()!.phoneNumber!);
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
              )),
          actions: [
            Visibility(
              visible:
                  getUser()!.phoneNumber == documentSnapshot.data()['mobile'],
              child: IconButton(
                  onPressed: () {
                    String postId = documentSnapshot.data()['postId'];
    
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alert(context, 'Do you want to delete?', () async {
                          await UserPost().deletePost(postId: postId);
    
                          PostFirebaseStorage().deletePostFromFirebaseStorage(
                              docId: postId,
                              mobile: documentSnapshot.data()['mobile']);
                          Get.back();
                          Get.back();
                        });
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: kWhite,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: PostCardWidget(
          isLiked: isLiked,
          documentSnapshot: documentSnapshot,
          isSaved: isSaved,
        )),
      );
    },
    );
  }
}
