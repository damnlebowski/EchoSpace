import 'package:get/get.dart';

class PostCardController extends GetxController {
  RxBool isSaved = false.obs;
  RxBool isLiked = false.obs;

  RxInt likes = 0.obs;

  savedToRxSaved(bool value) {
    isSaved.value = value;
  }

  likedToRxLiked(bool value, int like) {
    isLiked.value = value;

    likes.value = like;
  }
}
