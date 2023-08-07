import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickAndCrop {
  Future<File?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      File? img = File(image.path);
      img = await cropImage(imageFile: img);
      return img;
    } on PlatformException catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    final croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
