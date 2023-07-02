import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/services/saved_post.dart';

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
