import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UplodeProfileImageFirebase {
  Future<String> imageToUrlProfilePic(String mobile, XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_profile_images')
          .child(mobile);
      final uploadTask = storageRef.putFile(File(image.path));
      final taskSnapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
