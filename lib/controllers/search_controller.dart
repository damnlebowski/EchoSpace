import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  RxList userList = [].obs;

  serach(String querry) async {
    userList.value = await FirebaseFirestore.instance
        .collection('user_details')
        .where(
          'name',
          isGreaterThanOrEqualTo: querry.toLowerCase(),
        )
        .get()
        .then((value) => value.docs);
  }
}
