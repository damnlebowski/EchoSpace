import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/models/post_models.dart';
import 'package:echospace/services/upload_post_firebase.dart';
import 'package:echospace/services/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class UserPost {
  Future<void> createPost(File image, String title) async {
    User? user = FirebaseAuth.instance.currentUser;

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
          time: Timestamp.fromDate(DateTime.now()),
          likes: [],
          saved: [],
          comments: []);

      newPostRef.set(model.toJson());

      print('Post created successfully');

      // Store comments separately under the post document
      for (String comment in model.comments) {
        await newPostRef.collection('comments').add({
          'commentText': comment,
          'timestamp': Timestamp.fromDate(DateTime.now()),
        });
      }

      print('Comments stored successfully');
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  Future<void> deletePost({required String postId}) async {
    try {
      CollectionReference userPostsCollection =
          FirebaseFirestore.instance.collection('user_posts');

      await userPostsCollection.doc(postId).delete();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Future<List<Post>> getUserPosts() async {
  //   List<Post> userPosts = [];

  //   try {
  //     CollectionReference userPostsCollection =
  //         FirebaseFirestore.instance.collection('user_posts');

  //     QuerySnapshot postSnapshot = await userPostsCollection.get();

  //     for (QueryDocumentSnapshot postDoc in postSnapshot.docs) {
  //       List<String> comments = [];

  //       // Retrieve comments for each post
  //       CollectionReference commentsCollection =
  //           postDoc.reference.collection('comments');
  //       QuerySnapshot commentsSnapshot = await commentsCollection.get();

  //       for (QueryDocumentSnapshot commentDoc in commentsSnapshot.docs) {
  //         comments.add(
  //           commentDoc.get('commentText'),
  //         );
  //       }

  //       Post post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

  //       userPosts.add(post);
  //     }

  //     print('User posts retrieved successfully');
  //   } catch (e) {
  //     print('Error retrieving user posts: $e');
  //   }
  //   return userPosts;
  // }
}
