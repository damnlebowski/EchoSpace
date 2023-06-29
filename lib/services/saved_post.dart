import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SavedPosts {
  User? user = FirebaseAuth.instance.currentUser;

  addSavedPost({required Map<String, dynamic> post}) async {
    final ref = FirebaseFirestore.instance;
    await ref
        .collection('user_details')
        .doc(user!.phoneNumber)
        .collection('saved_posts')
        .doc(post['postId'])
        .set({'postId': post['postId']});
  }

  removeSavedPost({required String docId}) async {
    final ref = FirebaseFirestore.instance;
    final file = ref
        .collection('user_details')
        .doc(user!.phoneNumber)
        .collection('saved_posts')
        .doc(docId);
    await file.delete();
  }

  Future<List<String>> userSavedPost() async {
    List<String> list = [];
    final userPostsCollection = FirebaseFirestore.instance
        .collection('user_details')
        .doc(user!.phoneNumber)
        .collection('saved_posts');
    final docs = await userPostsCollection.get();
    list.addAll(docs.docs.map((e) => e['postId']));
    return list;
  }
}
