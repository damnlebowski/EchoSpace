import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PostFirebaseStorage {
  Future<String> imageToUrlPost(
    String userId,
    XFile image,
    String docId,
  ) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_posts')
          .child(userId)
          .child(docId);

      final uploadTask = storageRef.putFile(File(image.path));
      final taskSnapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.toString();
    }
  }

  deletePostFromFirebaseStorage(
      {required String docId, required String mobile}) async {
    try {
      Reference file = FirebaseStorage.instance
          .ref()
          .child('user_posts')
          .child(mobile)
          .child(docId);
      await file.delete();
    } catch (e) {
      print(e);
    }
  }
}
