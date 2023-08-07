import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/models/post_models.dart';
import 'package:echospace/services/post_count.dart';
import 'package:echospace/services/upload_post_firebase.dart';
import 'package:echospace/services/user_details.dart';
import 'package:echospace/utils/functions/get_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class UserPost {
  Future<void> createPost(File image, String title) async {
    User? user = getUser();

    try {
      CollectionReference userPostsCollection =
          FirebaseFirestore.instance.collection('user_posts');

      final newPostRef = userPostsCollection.doc();

      final details =
          await UserDetails().fetchDetailsOfUser(user!.phoneNumber!);

      String imgUrl = await PostFirebaseStorage()
          .imageToUrlPost(user.phoneNumber!, XFile(image.path), newPostRef.id);

      Post model = Post(
          userName: details.get('userName'),
          postId: newPostRef.id,
          mobile: '${user.phoneNumber}',
          imageUrl: imgUrl,
          title: title,
          time: Timestamp.now(),
          likes: [],
          saved: [],
          comments: []);

      newPostRef.set(model.toJson());

      print('Post created successfully');

      await PostCount().increment();

      print('Comments stored successfully');
    } catch (e) {
      print('Error creating post: $e');
    }
  }

//add comment
  addComment(String postId, String commentText, String mobile) async {
    print(mobile);
    final userDoc = await FirebaseFirestore.instance
        .collection('user_details')
        .doc(mobile)
        .get();

    CollectionReference userPostsCollection =
        FirebaseFirestore.instance.collection('user_posts');
    await userPostsCollection.doc(postId).update({
      'comments': FieldValue.arrayUnion([
        {
          'comment_id': commentText,
          'comment_text': commentText,
          'user_name': userDoc.get('userName'),
          'time': Timestamp.now(),
        }
      ])
    });
  }

//remove comment
  removeComment(String postId, String commentText, String user) async {
    CollectionReference userPostsCollection =
        FirebaseFirestore.instance.collection('user_posts');
    await userPostsCollection.doc(postId).update({
      'likes': FieldValue.arrayUnion([
        {
          'comment_text': commentText,
          'user_name': user,
          'time': Timestamp.now(),
        }
      ])
    });
  }

  Future<void> deletePost({required String postId}) async {
    try {
      CollectionReference userPostsCollection =
          FirebaseFirestore.instance.collection('user_posts');

      await userPostsCollection.doc(postId).delete();
      await PostCount().decrement();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

}
