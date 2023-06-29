// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/core/constants/colors.dart';
import 'package:echospace/core/constants/widgets.dart';
import 'package:echospace/services/like_post.dart';
import 'package:echospace/services/saved_post.dart';
import 'package:echospace/services/user_post.dart';
import 'package:echospace/views/image_view_screen/image_view_screen.dart';
import 'package:echospace/views/widgets/post_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
                style: TextStyle(color: kWhite, fontSize: 20));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'You are the first create new post.',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              bool isLiked = (snapshot.data!.docs[index].data()['likes']
                      as List<dynamic>)
                  .contains(FirebaseAuth.instance.currentUser!.phoneNumber!);
              bool isSaved = (snapshot.data!.docs[index].data()['saved']
                      as List<dynamic>)
                  .contains(FirebaseAuth.instance.currentUser!.phoneNumber!);
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

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays >= 2) {
    return DateFormat.MMMd().format(dateTime);
  } else if (difference.inDays == 1) {
    return '1 Day ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inSeconds >= 5) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inSeconds < 5 && difference.inSeconds >= 0) {
    return 'just now';
  } else {
    return 'Post from future';
  }
}

Future<bool> likePost(String mobile, Map<String, dynamic> post) async {
  final docRef =
      FirebaseFirestore.instance.collection('user_posts').doc(post['postId']);
  final snap = await docRef.get();

  //checking is liked or not
  if ((snap['likes'] as List<dynamic>).contains(mobile)) {
    await docRef.update({
      'likes': FieldValue.arrayRemove([mobile]),
    });
    LikedPosts().removeLikePost(docId: post['postId']);
    return false;
  } else {
    await docRef.update({
      'likes': FieldValue.arrayUnion([mobile]),
    });
    LikedPosts().addLikePost(post: post);

    return true;
  }
}

Future<bool> savePost(String mobile, Map<String, dynamic> post) async {
  final docRef =
      FirebaseFirestore.instance.collection('user_posts').doc(post['postId']);
  final snap = await docRef.get();

  //checking is saved or not
  if ((snap['saved'] as List<dynamic>).contains(mobile)) {
    await docRef.update({
      'saved': FieldValue.arrayRemove([mobile]),
    });
    SavedPosts().removeSavedPost(docId: post['postId']);
    return false;
  } else {
    await docRef.update({
      'saved': FieldValue.arrayUnion([mobile]),
    });
    SavedPosts().addSavedPost(post: post);

    return true;
  }
}
