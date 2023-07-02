import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/utils/constants/colors.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:echospace/views/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user_posts')
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: kRed,
            ));
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}',
                style: const TextStyle(color: kWhite, fontSize: 20));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'You are the first create new post.',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              bool isLiked =
                  (snapshot.data!.docs[index].data()['likes'] as List<dynamic>)
                      .contains(getUser()!.phoneNumber!);
              bool isSaved =
                  (snapshot.data!.docs[index].data()['saved'] as List<dynamic>)
                      .contains(getUser()!.phoneNumber!);
              return PostCardWidget(
                isLiked: isLiked,
                isSaved: isSaved,
                documentSnapshot: snapshot.data!.docs[index],
              );
            },
          );
        });
  }
}
