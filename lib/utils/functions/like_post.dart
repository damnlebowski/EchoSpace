
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/services/like_post.dart';

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
