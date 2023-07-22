import 'package:cloud_firestore/cloud_firestore.dart';

class UserNameList {
  Future<bool> checkForUsernameAvailablity(String userName) async {
    List<String> userNameList = [];

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('user_details').get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data.keys.contains('userName')) {
          String value = data['userName']!;
          userNameList.add(value);
        }
      }

      print('Field values retrieved successfully');
    } catch (e) {
      print('Error retrieving field values: $e');
    }
    print(userNameList.contains(userName));
    print(userNameList);
    print(userName);
    return !userNameList.contains(userName);
  }
}
