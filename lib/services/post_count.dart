import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/utils/functions/get_user.dart';

class PostCount {
  Future<void> increment() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      DocumentReference documentReference =
          firestore.collection('user_details').doc(getUser()!.phoneNumber);

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (snapshot.exists) {
          int currentLikes = (snapshot.data() as Map<String, dynamic>)['posts'];
          transaction.update(documentReference, {'posts': currentLikes + 1});
        }
      });
      print('posts incremented successfully!');
    } catch (e) {
      print('Error incrementing posts: $e');
    }
  }

  Future<void> decrement() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      DocumentReference documentReference =
          firestore.collection('user_details').doc(getUser()!.phoneNumber);

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        if (snapshot.exists) {
          int currentLikes = (snapshot.data() as Map<String, dynamic>)['posts'];
          transaction.update(documentReference, {'posts': currentLikes - 1});
        }
      });
      print('posts decrement successfully!');
    } catch (e) {
      print('Error decrement posts: $e');
    }
  }
}
