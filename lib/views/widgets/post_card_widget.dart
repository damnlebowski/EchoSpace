import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:echospace/services/saved_post.dart';
import 'package:echospace/views/image_view_screen/image_view_screen.dart';
import 'package:echospace/views/screen_home/screen_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget(
      {super.key,
      required this.isLiked,
      required this.documentSnapshot,
      required this.isSaved});

  final bool isLiked;
  final bool isSaved;
  final QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHeight10,
          Text(
            formatDateTime(
                (documentSnapshot.data()['time'] as Timestamp).toDate()),
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          kHeight1,
          Text(
            documentSnapshot.data()['userName'],
            style: const TextStyle(
                color: kWhite, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          kHeight1,
          Text(
            documentSnapshot.data()['title'],
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: kWhite, fontSize: 23, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          kHeight10,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: kWhite)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => FullScreenImage(
                      image: documentSnapshot.data()['imageUrl'])),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(documentSnapshot.data()['imageUrl']),
                  ),
                ),
                Row(
                  children: [
                    kWidth10,
                    GestureDetector(
                      onTap: () async {
                        String mobile =
                            FirebaseAuth.instance.currentUser!.phoneNumber!;

                        likePost(mobile, documentSnapshot.data());
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_circle_up_outlined,
                            color: isLiked ? kRed : kWhite,
                          ),
                          Text(
                            '  ${(documentSnapshot.data()['likes'] as List<dynamic>).length} Likes',
                            style: TextStyle(color: isLiked ? kRed : kWhite),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.comment,
                          color: kWhite,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          await Share.share(
                            'Hey, check out this image!\n${documentSnapshot.data()['imageUrl']}',
                          );
                        },
                        icon: const Icon(
                          Icons.share,
                          color: kWhite,
                        )),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          String mobile =
                              FirebaseAuth.instance.currentUser!.phoneNumber!;

                          savePost(mobile, documentSnapshot.data());
                        },
                        icon: Icon(
                          Icons.save_outlined,
                          color: isSaved ? kRed : kWhite,
                        )),
                    kWidth10,
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
