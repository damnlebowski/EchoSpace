import 'package:get/get.dart';

class AvatarController extends GetxController {
  RxString galleryImg = ''.obs;

  RxString appImg =
      'https://firebasestorage.googleapis.com/v0/b/echospace-7dbf6.appspot.com/o/costume_image%2Fimg01.jpg?alt=media&token=7badbe39-7e2e-42f3-ac39-e2d30ab51ec3'
          .obs;
  onClick(String img) {
    appImg.value = img;
    galleryImg.value = '';

  
  }
}
