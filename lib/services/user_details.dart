import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echospace/models/user_model.dart';

class UserDetails {
  addDetailsOfUser(UserModel model) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection('user_details');
    await ref.doc(model.mobile).set(model.toJson());
  }

  Future<DocumentSnapshot> fetchDetailsOfUser(String userId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('user_details')
        .doc(userId)
        .get();

    return documentSnapshot;
  }

  Future<bool> isUserIdExists(String userId) async {
    bool isDocumentExists = await FirebaseFirestore.instance
        .collection('user_details')
        .doc(userId)
        .get()
        .then((doc) => doc.exists);
    return isDocumentExists;
  }
}
