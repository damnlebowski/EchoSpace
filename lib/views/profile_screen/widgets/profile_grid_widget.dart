
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/post_view_screen/post_view_screen.dart';
import 'package:echospace/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileGridWidget extends StatelessWidget {
  const ProfileGridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user_posts')
            .where('mobile',
                isEqualTo:
                  getUser()!.phoneNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: CustomText(
              label: 'No Posts Yet..',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ));
          }
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.to(() => ViewPostPage(
                    documentSnapshot: snapshot.data!.docs[index]));
              },
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(snapshot.data?.docs[index]
                              .get('imageUrl'))))),
            ),
          );
        });
  }
}