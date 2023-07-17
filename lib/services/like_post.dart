import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/utils/functions/get_user.dart';
import 'package:echospace/views/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikedPosts {
  User? user = getUser();

  addLikePost({required Map<String, dynamic> post}) async {
    final ref = FirebaseFirestore.instance;
    await ref
        .collection('user_details')
        .doc(user!.phoneNumber)
        .collection('liked_posts')
        .doc(post['postId'])
        .set({'postId': post['postId']});
  }

  removeLikePost({required String docId}) async {
    final ref = FirebaseFirestore.instance;
    final collection = ref
        .collection('user_details')
        .doc(user!.phoneNumber)
        .collection('liked_posts')
        .doc(docId);
    await collection.delete();
  }

  Future<List<String>> userLikedPost() async {
    List<String> list = [];
    final userPostsCollection = FirebaseFirestore.instance
        .collection('user_details')
        .doc(user!.phoneNumber)
        .collection('liked_posts');
    final docs = await userPostsCollection.get();
    list.addAll(docs.docs.map((e) => e['postId']));
    return list;
  }
}
